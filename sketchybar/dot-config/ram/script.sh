#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source $CONFIG_ROOT/vars.sh

memory=(
  icon="󰘚"
  icon.color="$COLOR_WARNING"
  update_freq=15
  script="$CONFIG_ROOT/ram/script.sh"
)

sketchybar \
  --add item memory right \
  --set      memory "${memory[@]}"
