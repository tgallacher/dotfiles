#!/usr/bin/env bash

FILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"

rofi \
  -no-config \
  -no-lazy-grab \
  -show ${1:-'drun'} \
  -modi drun,window \
  -theme ~/.config/polybar/scripts/rofi/launcher.rasi
