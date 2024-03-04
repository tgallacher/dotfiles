{
  self,
  config,
  ...
}: {
  xdg.configFile = {
    "sketchybar/battery/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        battery_details=(
            background.corner_radius=12
            background.padding_left=5
            background.padding_right=10
            icon.background.height=2
            icon.background.y_offset=-12
            )

        sketchybar                                                           \
        --add item battery right                                           \
        --set battery update_freq=10                                       \
        icon.font="$NERD_FONT:Bold:16"                       \
        script="$CONFIG_ROOT/battery/script.sh"              \
        --subscribe battery mouse.entered mouse.exited mouse.exited.global \
        \
        --add item battery.details popup.battery                           \
        --set battery.details "''${battery_details[@]}"
      '';
    };

    "sketchybar/battery/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        function low_battery_label() {
          if [[ "$BATT_PERCENT" -lt 50 ]]; then
            sketchybar --set "$NAME" label="$BATT_PERCENT%" label.drawing=on
          else
            sketchybar --set "$NAME" label.drawing=off
          fi
        }

        function render_bar_item() {
          if [ $IS_CHARGING -eq 1 ]; then
            case $BATT_PERCENT in
            100) ICON="󰂄" COLOR="$GREEN" ;;
            9[0-9]) ICON="󰂋" COLOR="$GREEN" ;;
            8[0-9]) ICON="󰂊" COLOR="$GREEN" ;;
            7[0-9]) ICON="󰢞" COLOR="$GREEN" ;;
            6[0-9]) ICON="󰂉" COLOR="$YELLOW" ;;
            5[0-9]) ICON="󰢝" COLOR="$YELLOW" ;;
            4[0-9]) ICON="󰂈" COLOR="$PEACH" ;;
            3[0-9]) ICON="󰂇" COLOR="$PEACH" ;;
            2[0-9]) ICON="󰂆" COLOR="$RED" ;;
            1[0-9]) ICON="󰢜" COLOR="$RED" ;;
            *) ICON="󱃍" COLOR="$RED" ;;
            esac
          else
            case $BATT_PERCENT in
            100) ICON="󰁹" COLOR="$GREEN" ;;
            9[0-9]) ICON="󰂂" COLOR="$GREEN" ;;
            8[0-9]) ICON="󰂁" COLOR="$GREEN" ;;
            7[0-9]) ICON="󰂀" COLOR="$GREEN" ;;
            6[0-9]) ICON="󰁿" COLOR="$YELLOW" ;;
            5[0-9]) ICON="󰁾" COLOR="$YELLOW" ;;
            4[0-9]) ICON="󰁽" COLOR="$PEACH" ;;
            3[0-9]) ICON="󰁼" COLOR="$PEACH" ;;
            2[0-9]) ICON="󰁻" COLOR="$RED" ;;
            1[0-9]) ICON="󰁺" COLOR="$RED" ;;
            *) ICON="󱃍" COLOR="$RED" ;;
            esac

            sketchybar --set "$NAME" label="$BATT_PERCENT%"
          fi

          sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
          low_battery_label
        }

        function render_popup() {
          LABEL="$BATT_PERCENT%"
          if [ $BATT_REMAINING != "" ]; then LABEL="$BATT_PERCENT% / $BATT_REMAINING"; fi

          battery_details=(
            label="$LABEL"
            label.padding_right=0
            label.padding_right=0
            label.align=center
            click_script="sketchybar --set $NAME popup.drawing=off"
          )

          args+=(--set battery.details "''${battery_details[@]}")

          sketchybar "''${args[@]}" >/dev/null
        }

        function popup() {
          BATT_PERCENT=$(sketchybar --query battery.details | jq -r '.label.value | sub("%"; "") | head -n1')

          sketchybar --set "$NAME" popup.drawing="$1"
        }

        function update() {
          BATT_COMMAND=$(pmset -g batt)
          BATT_PERCENT=$(echo "$BATT_COMMAND" | grep -oE '[0-9]+%' | cut -d% -f1)
          BATT_REMAINING=$(echo "$BATT_COMMAND" | grep -oE '[0-9]{1,2}:[0-9]{1,2}\sremaining' | cut -d' ' -f1 | sed s/:/\\t/ | awk '{text = $1 "hrs " $2 "mins remaining"; print text};')
          IS_CHARGING=$(
            echo "$BATT_COMMAND" | head -n1 | grep -v 'AC Power' >/dev/null
            echo $?
          )

          render_bar_item
          render_popup
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
