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

        # FIXME: Requires SIP disabled for yabai focus
        FOCUS_SPACE_SH=$(yabai -m space --focus $(sed s/space\./$NAME/); sketchybar --trigger space_change;)
        SPACE_SIDS=(1 2 3 4 5 6 7)
        SPACE_COLORS=(
          $COLOR_PRIMARY
          $COLOR_SECONDARY
          $COLOR_TERTIARY
          $COLOR_SUCCESS
          $COLOR_ERROR
          $COLOR_WARNING
          $COLOR_INFORMATION
        )

        for idx in "''${!SPACE_SIDS[@]}"; do
          sid=''${SPACE_SIDS[idx]}

          sketchybar                                                      \
            --add space space.$sid left                                   \
            --set space.$sid  space=$sid                                  \
                              icon="$sid"                                 \
                              icon.padding_right=0                        \
                              icon.color="''${SPACE_COLORS[idx]}"         \
                              icon.highlight_color=$COLOR_BAR             \
                              background.color="''${SPACE_COLORS[idx]}"   \
                              background.drawing=off                      \
                              background.border_width=0                   \
                              background.corner_radius=3                  \
                              background.height=24                        \
                              label.font="$SKETCHYAPP_FONT:Regular:12.0"  \
                              label.highlight_color=$COLOR_BAR            \
                              label.padding_right=10                      \
                              label.padding_left=0                        \
                              label.y_offset=-1                           \
                              label.color="''${SPACE_COLORS[idx]}"        \
                              script="$CONFIG_ROOT/spaces/script.sh"      \
                              click_script="$FOCUS_SPACE_SH"              \
            --subscribe space.$sid mouse.clicked
        done

        sketchybar                                                            \
          --add item space_separator left                                     \
          --set      space_separator icon=""                                 \
                                     icon.color=$COLOR_PRIMARY                \
                                     icon.padding_left=3                      \
                                     icon.font="$NERD_FONT:Regular:14.0"      \
                                     label.drawing=off                        \
                                     background.drawing=off                   \
                                     script="$CONFIG_ROOT/spaces/windows.sh"  \
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
            --set $NAME background.drawing=on           \
                        label.highlight=on              \
                        icon.highlight=on
        else
          sketchybar                                    \
            --set $NAME background.drawing=off          \
                        label.highlight=off             \
                        icon.highlight=off
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
