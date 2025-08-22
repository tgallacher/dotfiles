#!/usr/bin/env bash
# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

function get_icon()
{
  source /nix/store/hf629pj1q3a1zf1hrklr5i78fv7iqix6-icon_map.sh
  icon_result=":default:"

  __icon_map "$1"

  echo "$icon_result"
}

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO" icon.drawing=off
  # sketchybar --set $NAME label="$INFO" icon="$(get_icon "$INFO")"
fi
