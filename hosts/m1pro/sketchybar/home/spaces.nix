{
  config,
  icon_map_sh,
  ...
}: {
  xdg.configFile = {
    "sketchybar/spaces/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        # FIXME: Requires SIP disabled for yabai focus
        # FOCUS_SPACE_SH=$(yabai -m space --focus $(sed s/space\./$NAME/); sketchybar --trigger space_change;)
        SPACE_SIDS=(1 2 3 4 5)
        SPACE_COLORS=(
          "$COLOR_PRIMARY"
          "$COLOR_SECONDARY"
          "$COLOR_TERTIARY"
          "$COLOR_SUCCESS"
          "$COLOR_ERROR"
          "$COLOR_WARNING"
          "$COLOR_INFORMATION"
        )
        SPACE_ICONS=(
          ""
          "󱌢"
          "󰙏"
          ""
          "󰎈"
        )

        for idx in "''${!SPACE_SIDS[@]}"; do
          sid=''${SPACE_SIDS[idx]}

          sketchybar                                                          \
            --add space space.$sid left                                       \
            --set space.$sid  space="$sid"                                    \
                              icon="''${SPACE_ICONS[idx]}"                    \
                              icon.highlight_color="$COLOR_BAR"               \
                              icon.background.color="''${SPACE_COLORS[idx]}"  \
                              icon.background.height=18                       \
                              icon.background.drawing=off                     \
                              icon.background.corner_radius="$RADIUS"         \
                              icon.y_offset=1                                 \
                              icon.padding_left=4                             \
                              icon.padding_right=4                            \
                                                                              \
                              script="$CONFIG_ROOT/spaces/script.sh"          \
            --subscribe       "space.$sid" mouse.clicked
        done

        sketchybar                                                            \
          --add item space_separator left                                     \
          --set      space_separator icon=""                                 \
                                     icon.color="$COLOR_PRIMARY"              \
                                     icon.padding_left=3                      \
                                     icon.font="$NERD_FONT:Bold:14.0"         \
                                     label.drawing=off                        \
          --subscribe space_separator space_windows_change
      '';
    };

    "sketchybar/spaces/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # The $SELECTED variable is available for space components and indicates if
        # the space invoking this script (with name: $NAME) is currently selected:
        # https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        if [ $SELECTED = true ]; then
          sketchybar                                    \
            --set $NAME label.highlight=on              \
                        icon.highlight=on               \
                        icon.background.drawing=on

        else
          sketchybar                                    \
            --set $NAME label.highlight=off             \
                        icon.highlight=off              \
                        icon.background.drawing=off

        fi
      '';
    };

    # TODO: no longer used, so remove
    "sketchybar/spaces/windows.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        function get_icon() {
          source ${icon_map_sh}
          icon_result=""

          __icon_map "$1"

          echo "$icon_result"
        }

        if [ "$SENDER" = "space_windows_change" ]; then
          space="$(echo "$INFO" | jq -r '.space')"
          apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

          icon_strip=" "
          if [ "''${apps}" != "" ]; then
            while read -r app; do
              icon_strip+=" $(get_icon "$app")"
            done <<<"''${apps}"
          else
            icon_strip=" —"
          fi

          sketchybar --set space.$space label="$icon_strip"
        fi
      '';
    };
  };
}
