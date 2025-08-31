#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

memory=(
  icon="󰘚"
  update_freq=15
  script="$CONFIG_ROOT/ram/script.sh"
)

sketchybar \
  --add item memory right \
  --set      memory "${memory[@]}"
