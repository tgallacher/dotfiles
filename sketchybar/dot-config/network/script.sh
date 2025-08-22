#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source $CONFIG_ROOT/vars.sh

network_down=(
  y_offset=-5
  icon=""
  icon.highlight_color="$COLOR_INFORMATION"
  label.font="$NERD_FONT:Regular:11"
  update_freq=1
  script="$CONFIG_ROOT/network/script.sh"
)

network_up=(
  background.padding_right=-77
  y_offset=5
  icon=""
  icon.highlight_color="$COLOR_SECONDARY"
  label.font="$NERD_FONT:Regular:11"
)

sketchybar \
  --add item network.down right \
  --set network.down "${network_down[@]}" \
  \
  --add item network.up right \
  --set network.up "${network_up[@]}"
