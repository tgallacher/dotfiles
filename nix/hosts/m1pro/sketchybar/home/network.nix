{ self
, config
, upkgs
, osConfig
, ...
}: {
  xdg.configFile = {
    "sketchybar/network/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        network_down=(
          y_offset=-7
          icon=""
          icon.highlight_color="$COLOR_SECONDARY"
          update_freq=1
          script="$CONFIG_ROOT/network/network.sh"
        )

        network_up=(
          background.padding_right=-86
          y_offset=7
          icon=""
          icon.highlight_color="$COLOR_SECONDARY"
        )

        sketchybar                                  \
          --add item network.down right             \
          --set network.down "''${network_down[@]}" \
                                                    \
          --add item network.up right               \
          --set network.up "''${network_up[@]}"
      '';
    };

    "sketchybar/network/network.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        IFSTAT="$(${osConfig.homebrew.brewPrefix}/brew --prefix ifstat)/bin/ifstat"

        INTERFACE=$(route -n get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2};')
        UPDOWN=$($IFSTAT -i "$INTERFACE" -b 0.1 1 | tail -n1)
        DOWN=$(echo "$UPDOWN" | awk "{ print \$1 };" | cut -f1 -d ".")
        UP=$(echo "$UPDOWN" | awk "{ print \$2 };" | cut -f1 -d ".")

        DOWN_LABEL=""
        if [ "$DOWN" -gt "999" ]; then
          DOWN_LABEL=$(echo "$DOWN" | awk '{ printf "%03.0f Mbps", $1 / 1000};')
        else
          DOWN_LABEL=$(echo "$DOWN" | awk '{ printf "%03.0f kbps", $1};')
        fi

        UP_LABEL=""
        if [ "$UP" -gt "999" ]; then
          UP_LABEL=$(echo "$UP" | awk '{ printf "%03.0f Mbps", $1 / 1000};')
        else
          UP_LABEL=$(echo "$UP" | awk '{ printf "%03.0f kbps", $1};')
        fi

        UP_TRAFFIC="off"
        if [ "$UP" -gt 0 ]; then UP_TRAFFIC="on"; fi
        DOWN_TRAFFIC="off"
        if [ "DOWN" -gt 0 ]; then DOWN_TRAFFIC="on"; fi

        sketchybar                                                                    \
          --set network.down label="''${DOWN_LABEL}" icon.highlight="''${DOWN_TRAFFIC}"   \
          --set network.up   label="''${UP_LABEL}"   icon.highlight="''${UP_TRAFFIC}"
      '';
    };
  };
}

