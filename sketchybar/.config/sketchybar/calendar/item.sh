#!/usr/bin/env bash
# shellcheck disable=SC2016

date=(
  icon.drawing=off
  label.font="$NERD_FONT:Semibold:10"
  label.padding_left=0
  label.padding_right=4
  y_offset=6
  width=0
  update_freq=60
  script='sketchybar --set "$NAME" label="$(date "+%d %b")"'
  click_script="open -a Calendar.app"
)

clock=(
  # "${menu_defaults[@]}"
  icon.drawing=off
  label.font="$NERD_FONT:Bold:13"
  label.padding_right=4
  y_offset=-4
  update_freq=10
  popup.align=right
  script='sketchybar --set $NAME label="$(date "+%H:%M")"'
  click_script="sketchybar --set clock popup.drawing=toggle"
)

sketchybar \
  --add item date right \
  --set date "${date[@]}" \
  --subscribe date system_woke mouse.entered mouse.exited mouse.exited.global \
  \
  --add item date.details popup.date \
  \
  --add item clock right \
  --set clock "${clock[@]}" \
  --subscribe clock system_woke mouse.entered mouse.exited mouse.exited.global \
  \
  --add item clock.next_event popup.clock \
  --set clock.next_event icon.drawing=off label.padding_left=0 label.max_chars=22
