#!/usr/bin/env bash
CONFIG_ROOT=~/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

function low_battery_label()
{
  if [[ "$BATT_PERCENT" -lt 50 ]]; then
    sketchybar --set "$NAME" label="$BATT_PERCENT%" label.drawing=on
  else
    sketchybar --set "$NAME" label.drawing=off
  fi
}

function render_bar_item()
{
  COLOR="$COLOR_DICON"

  if [[ "$IS_CHARGING" -eq "1" ]]; then
    ICON="􀢋"
  else
    if [ "$BATT_PERCENT" -eq "100" ]; then
      ICON="􀛨"
    elif [ "$BATT_PERCENT" -ge "75" ]; then
      ICON="􀛨"
    elif [ "$BATT_PERCENT" -ge "50" ]; then
      ICON="􀺶"
    elif [ "$BATT_PERCENT" -ge "25" ]; then
      ICON="􀛩"
      COLOR="$COLOR_WARNING"
    else
      ICON="􀛪"
      COLOR="$COLOR_ERROR"
    fi

    sketchybar --set "$NAME" label="$BATT_PERCENT%"
  fi

  sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
  low_battery_label
}

function render_popup()
{
  LABEL="$BATT_PERCENT%"
  if [ "$BATT_REMAINING" != "" ]; then
    LABEL="$BATT_PERCENT% / $BATT_REMAINING"
  fi

  battery_details=(
    label="$LABEL"
    label.padding_right=0
    label.padding_right=0
    label.align=center
    click_script="sketchybar --set $NAME popup.drawing=off"
  )

  args+=(--set battery.details "${battery_details[@]}")

  sketchybar "${args[@]}" > /dev/null
}

function popup()
{
  # TODO: being used?
  # BATT_PERCENT=$(sketchybar --query battery.details | jq -r '.label.value | sub("%"; "") | head -n1')

  sketchybar --set "$NAME" popup.drawing="$1"
}

function update()
{
  BATT_COMMAND=$(pmset -g batt)
  BATT_PERCENT=$(echo "$BATT_COMMAND" | grep -oE '[0-9]+%' | cut -d% -f1)
  BATT_REMAINING=$(echo "$BATT_COMMAND" | grep -oE '[0-9]{1,2}:[0-9]{1,2}\sremaining' | cut -d' ' -f1 | sed s/:/\\t/ | awk '{text = $1 "hrs " $2 "mins remaining"; print text};')
  IS_CHARGING=$(
    echo "$BATT_COMMAND" | head -n1 | grep -v 'AC Power' > /dev/null
    echo $?
  )

  render_bar_item
  render_popup
}

case "$SENDER" in
  "routine" | "forced")
    update
    ;;
  "mouse.entered")
    popup on
    ;;
  "mouse.exited" | "mouse.exited.global")
    popup off
    ;;
  "mouse.clicked")
    popup toggle
    ;;
esac
