#!/usr/bin/env bash
CONFIG_ROOT=/Users/tomgallacher/.config/sketchybar
source "$CONFIG_ROOT/vars.sh"

POPUP_OFF="sketchybar --set wifi popup.drawing=off"

NIC_INTF="en0"

CURRENT_WIFI="$(networksetup -getairportnetwork $NIC_INTF)"
WIFI_POWER="$(networksetup -getairportpower $NIC_INTF)"
IP_ADDRESS="$(ipconfig getifaddr $NIC_INTF)"
SSID="$(echo "$CURRENT_WIFI" | cut -d':' -f2 | sed 's/^ //' | sed 's/ $//')"
# CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"
CURR_TX="0"

ICON_COLOR=$COLOR_DICON
if [[ $WIFI_POWER == *"Off"* ]]; then
  ICON=􀙈
elif [[ $SSID != "" ]]; then
  ICON=􀙇
else
  ICON=󰤯
fi

render_bar_item()
                  {
  sketchybar --set "$NAME" \
    icon.color="$ICON_COLOR" \
    icon="$ICON" \
    click_script="$POPUP_CLICK_SCRIPT"
}

render_popup()
               {
  if [ "$SSID" != "" ]; then
    args=(
      --set wifi click_script="$POPUP_CLICK_SCRIPT"
      --set wifi.ssid label="$SSID"
      --set wifi.strength label="$CURR_TX Mbps"
      --set wifi.ipaddress label="$IP_ADDRESS"
      click_script="printf $IP_ADDRESS | pbcopy;$POPUP_OFF"
    )
  else
    args=(--set wifi click_script="")
  fi

  sketchybar "${args[@]}" > /dev/null
}

update()
         {
  render_bar_item
  render_popup
}

popup()
        {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
  "routine" | "forced")
    update
    ;;
  "mouse.entered")
    popup on
    ;;
  "mouse.exited" | "mouse.exited.global")
    popup off
    ;;
  "mouse.clicked")
    popup toggle
    ;;
esac
