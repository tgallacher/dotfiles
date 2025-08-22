#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source $CONFIG_ROOT/vars.sh

sketchybar \
  --add item front_app  left \
  --set      front_app  icon.font="$SKETCHYAPP_FONT:Regular:16.0" \
                        label.color=$COLOR_SECONDARY \
                        script="$CONFIG_ROOT/front_app/script.sh" \
  --subscribe front_app front_app_switched
