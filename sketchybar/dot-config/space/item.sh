#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source $CONFIG_ROOT/vars.sh

# FIXME: Requires SIP disabled for yabai focus
# FOCUS_SPACE_SH=$(yabai -m space --focus $(sed s/space\./$NAME/); sketchybar --trigger space_change;)
SPACE_SIDS=(1 2 3 4 5)
SPACE_COLORS=(
  "$COLOR_PRIMARY"
  "$COLOR_SECONDARY"
  "$COLOR_TERTIARY"
  "$COLOR_SUCCESS"
  "$COLOR_ERROR"
  "$COLOR_WARNING"
  "$COLOR_INFORMATION"
)
SPACE_ICONS=(
  "1"
  "2"
  "3"
  "4"
  "5"
)
for idx in "${!SPACE_SIDS[@]}"; do
  sid=${SPACE_SIDS[idx]}

  sketchybar \
    --add space space.$sid left \
    --set space.$sid  space="$sid" \
                      icon="${SPACE_ICONS[idx]}" \
                      icon.highlight_color="$COLOR_BAR" \
                      icon.background.color="$COLOR_PRIMARY" \
                      icon.background.height=18 \
                      icon.background.drawing=off \
                      icon.background.corner_radius="$RADIUS" \
                      icon.y_offset=1 \
                      icon.padding_left=4 \
                      icon.padding_right=4 \
                      label.drawing=off \
                      \
    script="$CONFIG_ROOT/spaces/script.sh" \
    --subscribe       "space.$sid" mouse.clicked
done

sketchybar \
  --add item space_separator left \
  --set      space_separator icon="" \
                             icon.color="$COLOR_PRIMARY" \
                             icon.padding_left=3 \
                             icon.font="$NERD_FONT:Bold:14.0" \
                             label.drawing=off \
  --subscribe space_separator space_windows_change
