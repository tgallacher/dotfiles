{
  self,
  config,
  pkgs,
  icon_map_sh,
  ...
}: {
  xdg.configFile = {
    "sketchybar/front_app/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        sketchybar                                                            \
          --add item front_app  left                                          \
          --set      front_app  background.color=$ACCENT_COLOR                \
                                icon.color=$BAR_COLOR                         \
                                icon.font="$SKETCHYAPP_FONT:Regular:16.0"     \
                                label.color=$BAR_COLOR                        \
                                script="$CONFIG_ROOT/front_app/script.sh"     \
          --subscribe front_app front_app_switched
      '';
    };

    "sketchybar/front_app/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # Some events send additional information specific to the event in the $INFO
        # variable. E.g. the front_app_switched event sends the name of the newly
        # focused application in the $INFO variable:
        # https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting


        function get_icon() {
          source ${icon_map_sh}
          icon_result=":default:"

          __icon_map "$1"

          echo "$icon_result"
        }

        if [ "$SENDER" = "front_app_switched" ]; then
          sketchybar --set $NAME label="$INFO" icon="$(get_icon "$INFO")"
        fi
      '';
    };
  };
}
