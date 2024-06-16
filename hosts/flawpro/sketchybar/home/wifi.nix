{config, ...}: {
  xdg.configFile = {
    "sketchybar/wifi/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
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

        sketchybar                                \
          --add item wifi right                   \
          --set wifi "''${wifi[@]}"               \
                                                  \
          --add item wifi.ssid popup.wifi         \
          --set wifi.ssid icon=􀅴                  \
            label="SSID"                          \
            click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
                                                  \
          --add item wifi.strength popup.wifi     \
          --set wifi.strength icon=􀋨              \
            label="Speed"                         \
            click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
                                                  \
          --add item wifi.ipaddress popup.wifi    \
          --set wifi.ipaddress icon=􀆪             \
            label="IP Address"                    \
            click_script="echo \"$IP_ADDRESS\"|pbcopy;$POPUP_OFF"
      '';
    };

    "sketchybar/wifi/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source "$CONFIG_ROOT/vars.sh"

        POPUP_OFF="sketchybar --set wifi popup.drawing=off"

        CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
        IP_ADDRESS="$(ipconfig getifaddr en0)"
        SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
        CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

        ICON_COLOR=$COLOR_DICON
        if [[ $SSID != "" ]]; then
          # ICON_COLOR="$COLOR_PRIMARY"
          ICON=􀙇
        elif [[ $CURRENT_WIFI = "AirPort: Off" ]]; then
          ICON=􀙈
        else
          # ICON_COLOR=$COLOR_PRIMARY
          ICON=􀙇
        fi

        render_bar_item() {
          sketchybar --set "$NAME"              \
            icon.color="$ICON_COLOR"            \
            icon="$ICON"                        \
            click_script="$POPUP_CLICK_SCRIPT"
        }

        render_popup() {
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

          sketchybar "''${args[@]}" >/dev/null
        }

        update() {
          render_bar_item
          render_popup
        }

        popup() {
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
      '';
    };
  };
}
