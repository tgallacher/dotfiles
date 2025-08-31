#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

WIDTH=100

toggle_detail()
                {
  INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")

  if [ "$INITIAL_WIDTH" -eq "0" ]; then
    sketchybar --animate tanh 30 --set volume slider.width="$WIDTH"
  else
    sketchybar --animate tanh 30 --set volume slider.width=0
  fi
}

toggle_devices()
                 {
  which SwitchAudioSource > /dev/null || exit 0

  args=(
    --remove '/volume.device\..*/'
    --set "$NAME" popup.drawing=toggle
  )

  COUNTER=0
  CURRENT="$(SwitchAudioSource -t output -c)"

  while IFS= read -r device; do
    COLOR=$WHITE
    ICON=􀆅
    ICON_COLOR=$COLOR_TRANSPARENT

    if [ "${device}" == "$CURRENT" ]; then
      COLOR=$COLOR_PRIMARY
      ICON_COLOR=$COLOR_PRIMARY
    fi

    args+=(
      --add item "volume.device.$COUNTER" "popup.$NAME"
      --set "volume.device.$COUNTER" label="${device}"
      label.color="$COLOR"
      icon="$ICON"
      icon.color="$ICON_COLOR"
      click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\..*/ label.color=$COLOR --set \$NAME label.color=$COLOR --set $NAME popup.drawing=off"
    )

    COUNTER=$((COUNTER + 1))
  done <<< "$(SwitchAudioSource -a -t output)"

  sketchybar -m "${args[@]}" > /dev/null
}

if [ "$BUTTON" = "left" ] || [ "$MODIFIER" = "shift" ]; then
  toggle_devices
else
  toggle_detail
fi
