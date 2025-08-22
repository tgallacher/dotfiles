#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

POPUP_OFF="sketchybar --set wifi popup.drawing=off"

wifi=(
  script="$CONFIG_ROOT/wifi/script.sh"
  click_script="sketchybar --set wifi popup.drawing=toggle"
  label.drawing=off
  icon.drawing=on
  popup.align=right
  icon.font="$SF_FONT:Regular:12"
  update_freq=20
  --subscribe wifi wifi_change mouse.entered mouse.exited mouse.exited.global
)

sketchybar \
  --add item wifi right \
  --set wifi "${wifi[@]}" \
  \
  --add item wifi.ssid popup.wifi \
  --set wifi.ssid icon=􀅴 \
    label="SSID" \
    click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  \
  --add item wifi.strength popup.wifi \
  --set wifi.strength icon=􀋨 \
    label="Speed" \
    click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  \
  --add item wifi.ipaddress popup.wifi \
  --set wifi.ipaddress icon=􀆪 \
    label="IP Address" \
    click_script="echo \"$IP_ADDRESS\"|pbcopy;$POPUP_OFF"
