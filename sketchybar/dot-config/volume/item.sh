#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

volume_slider=(
  script="$CONFIG_ROOT/volume/script.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color="$COLOR_PRIMARY"
  slider.background.height=8
  slider.background.corner_radius="$RADIUS"
  slider.background.color="$COLOR_DLABEL"
  padding_left=0
  padding_right=0
)

volume_icon=(
  click_script="$CONFIG_ROOT/volume/click.sh"
  icon="􀊧"
  icon.font="$SF_FONT:Regular:14"
  label.drawing=off
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change \
  mouse.clicked \
  mouse.entered \
  mouse.exited \
  mouse.exited.global \
  \
  --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}"
