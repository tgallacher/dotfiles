{
  self,
  config,
  upkgs,
  pkgs,
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

        FOCUS_SPACE_SH=$(yabai -m space --focus $(sed s/space\./$NAME/); sketchybar --trigger space_change;)
        SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)

        for sid in "''${SPACE_SIDS[@]}"; do
          sketchybar                                                      \
            --add space space.$sid left                                   \
            --set space.$sid  space=$sid                                  \
                              icon="$sid."                                \
                              icon.padding_right=0                        \
                              icon.margin_right=0                         \
                              label.font="$SKETCHYAPP_FONT:Regular:16.0"  \
                              label.padding_right=15                      \
                              label.padding_left=0                        \
                              label.margin_left=0                         \
                              label.y_offset=-1                           \
                              script="$CONFIG_ROOT/spaces/script.sh"      \
                              click_script="$FOCUS_SPACE_SH"              \
            --subscribe space.$sid mouse.clicked
        done

        sketchybar                                                        \
          --add item space_separator left                                 \
          --set space_separator icon="􀆊"                                  \
                                icon.color=$ACCENT_COLOR                  \
                                icon.padding_left=3                       \
                                label.drawing=off                         \
                                background.drawing=off                    \
                                script="$CONFIG_ROOT/spaces/windows.sh"   \
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


        if [ $SELECTED = true ]; then
          sketchybar                                    \
            --set $NAME background.drawing=on           \
                        background.color=$ACCENT_COLOR  \
                        label.color=$BAR_COLOR          \
                        icon.color=$BAR_COLOR
        else
          sketchybar                                    \
            --set $NAME background.drawing=off          \
                        label.color=$ACCENT_COLOR       \
                        icon.color=$ACCENT_COLOR
        fi
      '';
    };

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
