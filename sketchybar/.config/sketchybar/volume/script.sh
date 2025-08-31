#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

WIDTH=100

volume_change()
                {
  case $INFO in
    [6-9][0-9] | 100)
      ICON="􀊩"
      ;;
    [3-5][0-9])
      ICON="􀊧"
      ;;
    [1-2][0-9])
      ICON="􀊥"
      ;;
    [1-9])
      ICON="􀊥"
      ;;
    0)
      ICON="􀊣"
      ;;
    *)
      ICON="􀊩"
      ;;
  esac

  sketchybar --set volume_icon icon="$ICON" \
    --set "$NAME" \
    slider.percentage="$INFO" \
    slider.width=$WIDTH \
    --animate tanh 30

  sleep 2

  # Check wether the volume was changed  while sleeping
  FINAL_PERCENTAGE=$(sketchybar --query "$NAME" | jq -r ".slider.percentage")
  if ((FINAL_PERCENTAGE == INFO)); then
    sketchybar --animate tanh 30 --set "$NAME" slider.width=0
  fi
}

mouse_clicked()
                {
  osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
  "volume_change")
    volume_change
    ;;
  "mouse.clicked")
    mouse_clicked
    ;;
esac
