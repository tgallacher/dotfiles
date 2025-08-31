#!/usr/bin/env bash
CONFIG_ROOT=~/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

battery_details=(
  background.corner_radius=10
  background.padding_left=5
  background.padding_right=10
  icon.background.height=2
  icon.background.y_offset=-12
)

sketchybar \
  --add item battery right \
  --set battery update_freq=10 \
                icon.font="$NERD_FONT:Bold:16" \
                script="$CONFIG_ROOT/battery/script.sh" \
  --subscribe battery mouse.entered mouse.exited mouse.exited.global \
  \
  --add item battery.details popup.battery \
  --set battery.details "${battery_details[@]}"
