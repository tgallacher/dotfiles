#!/usr/bin/env bash
CONFIG_ROOT=~/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

COLOR="$COLOR_SUCCESS"

if [ "$MEMORY" -gt "70" ]; then
  COLOR="$COLOR_ERROR"
fi

sketchybar --set memory label="$MEMORY%" \
                           icon.color="$COLOR"
