#!/usr/bin/env bash
# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source $CONFIG_ROOT/vars.sh

if [ $SELECTED = true ]; then
  sketchybar \
    --set $NAME label.highlight=on \
                icon.highlight=on \
                icon.background.drawing=on

else
  sketchybar \
    --set $NAME label.highlight=off \
                icon.highlight=off \
                icon.background.drawing=off

fi
