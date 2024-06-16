{config, ...}: {
  xdg.configFile = {
    "sketchybar/volume/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source "$CONFIG_ROOT/vars.sh"

        volume_slider=(
          script="$CONFIG_ROOT/volume/script.sh"
          updates=on
          label.drawing=off
          icon.drawing=off
          slider.highlight_color="$COLOR_PRIMARY"
          slider.background.height=8
          slider.background.corner_radius="$RADIUS"
          slider.background.color="$COLOR_DLABEL"
          padding_left=0
          padding_right=0
        )

        volume_icon=(
          click_script="$CONFIG_ROOT/volume/click.sh"
          icon="􀊧"
          icon.font="$SF_FONT:Regular:14"
          label.drawing=off
        )

        sketchybar --add slider volume right        \
          --set volume "''${volume_slider[@]}"      \
          --subscribe volume volume_change          \
          mouse.clicked                             \
          mouse.entered                             \
          mouse.exited                              \
          mouse.exited.global                       \
                                                    \
          --add item volume_icon right              \
          --set volume_icon "''${volume_icon[@]}"
      '';
    };

    "sketchybar/volume/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source "$CONFIG_ROOT/vars.sh"

        WIDTH=100

        volume_change() {
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
            --set "$NAME"                           \
            slider.percentage="$INFO"               \
            slider.width=$WIDTH                     \
            --animate tanh 30

          sleep 2

          # Check wether the volume was changed  while sleeping
          FINAL_PERCENTAGE=$(sketchybar --query "$NAME" | jq -r ".slider.percentage")
          if ((FINAL_PERCENTAGE == INFO)); then
            sketchybar --animate tanh 30 --set "$NAME" slider.width=0
          fi
        }

        mouse_clicked() {
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
      '';
    };

    "sketchybar/volume/click.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source "$CONFIG_ROOT/vars.sh"

        WIDTH=100

        toggle_detail() {
          INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")

          if [ "$INITIAL_WIDTH" -eq "0" ]; then
            sketchybar --animate tanh 30 --set volume slider.width="$WIDTH"
          else
            sketchybar --animate tanh 30 --set volume slider.width=0
          fi
        }

        toggle_devices() {
          which SwitchAudioSource >/dev/null || exit 0

          args=(
            --remove '/volume.device\..*/'
            --set "$NAME" popup.drawing=toggle
          )

          COUNTER=0
          CURRENT="$(SwitchAudioSource -t output -c)"

          while IFS= read -r device; do
            COLOR=$WHITE
            ICON=􀆅
            ICON_COLOR=$COLOR_TRANSPARENT

            if [ "''${device}" == "$CURRENT" ]; then
              COLOR=$COLOR_PRIMARY
              ICON_COLOR=$COLOR_PRIMARY
            fi

            args+=(
              --add item "volume.device.$COUNTER" "popup.$NAME"
              --set "volume.device.$COUNTER" label="''${device}"
              label.color="$COLOR"
              icon="$ICON"
              icon.color="$ICON_COLOR"
              click_script="SwitchAudioSource -s \"''${device}\" && sketchybar --set /volume.device\..*/ label.color=$COLOR --set \$NAME label.color=$COLOR --set $NAME popup.drawing=off"
            )

            COUNTER=$((COUNTER + 1))
          done <<<"$(SwitchAudioSource -a -t output)"

          sketchybar -m "''${args[@]}" >/dev/null
        }

        if [ "$BUTTON" = "left" ] || [ "$MODIFIER" = "shift" ]; then
          toggle_devices
        else
          toggle_detail
        fi
      '';
    };
  };
}
