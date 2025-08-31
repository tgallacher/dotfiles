#!/usr/bin/env bash
CONFIG_ROOT=~/.config/sketchybar

sketchybar \
  --add item cpu right \
  --set cpu update_freq=10 \
            icon= \
            script="$CONFIG_ROOT/cpu/script.sh"
