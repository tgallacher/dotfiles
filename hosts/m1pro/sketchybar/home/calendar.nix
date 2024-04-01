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

        date=(
          icon.drawing=off
          label.font="$NERD_FONT:Semibold:10"
          label.padding_left=0
          label.padding_right=4
          y_offset=6
          width=0
          update_freq=60
          script='sketchybar --set "$NAME" label="$(date "+%d %b")"'
          click_script="open -a Calendar.app"
        )

        clock=(
          "''${menu_defaults[@]}"
          icon.drawing=off
          label.font="$NERD_FONT:Bold:13"
          label.padding_right=4
          y_offset=-4
          update_freq=10
          popup.align=right
          script='sketchybar --set $NAME label="$(date "+%H:%M")"'
          click_script="sketchybar --set clock popup.drawing=toggle"
        )

        sketchybar \
          --add item date right \
          --set date "''${date[@]}" \
          --subscribe date system_woke mouse.entered mouse.exited mouse.exited.global \
          \
          --add item date.details popup.date \
          \
          --add item clock right \
          --set clock "''${clock[@]}" \
          --subscribe clock system_woke mouse.entered mouse.exited mouse.exited.global \
          \
          --add item clock.next_event popup.clock \
          --set clock.next_event icon.drawing=off label.padding_left=0 label.max_chars=22

      '';
    };

    # TODO: re-introduce?
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

        if [ "$1" == "on" ]; then zen_on
        elif [ "$1" == "off" ]; then zen_off
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
