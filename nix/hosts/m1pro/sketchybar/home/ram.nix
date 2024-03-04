{
  self,
  config,
  ...
}: {
  xdg.configFile = {
    "sketchybar/ram/item.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        CONFIG_ROOT=${config.xdg.configHome}/sketchybar
        source $CONFIG_ROOT/vars.sh

        memory=(
          label.color="$WHITE"
          icon="󰘚"
          icon.color="$ITEM_BG_COLOR"
          update_freq=15
          script="$CONFIG_ROOT/ram/script.sh"
        )

        sketchybar                              \
          --add item memory right               \
          --set      memory "''${memory[@]}"
      '';
    };

    "sketchybar/ram/script.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

        sketchybar --set "$NAME" label="$MEMORY%"
      '';
    };
  };
}
