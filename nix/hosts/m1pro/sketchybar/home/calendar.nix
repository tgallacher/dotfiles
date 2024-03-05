{
  self,
  config,
  ...
}: {
  xdg.configFile = {
    "sketchybar/calendar/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar

        # TODO: Finish ZEN mode
        sketchybar                                                      \
          --add item calendar right                                     \
          --set calendar  icon=                                        \
                          update_freq=30                                \
                          script="$CONFIG_ROOT/calendar/script.sh"      \
                          click_script="$CONFIG_ROOT/calendar/zen.sh"
      '';
    };

    "sketchybar/calendar/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        sketchybar --set $NAME label="$(date +'%a %d %b %H:%M')"
      '';
    };

    "sketchybar/calendar/zen.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        zen_on() {
          sketchybar                              \
             --set apple.logo drawing=off         \
             --set '/space.*/' drawing=off        \
             --set volume_icon drawing=off        \
             --set space_separator drawing=off    \
             --set battery drawing=off            \
             --set memory drawing=off             \
             --set cpu drawing=off                \
             --set '/network.*/' drawing=off
        }

        zen_off() {
          sketchybar                             \
             --set apple.logo drawing=on         \
             --set '/space.*/' drawing=on        \
             --set volume_icon drawing=on        \
             --set space_separator drawing=on    \
             --set battery drawing=on            \
             --set memory drawing=on             \
             --set cpu drawing=on                \
             --set '/network.*/' drawing=on
        }

        if [ "$1" = "on" ]; then zen_on
        elif [ "$1" = "off" ]; then zen_off
        else
          if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
            zen_on
          else
            zen_off
          fi
        fi
      '';
    };
  };
}
