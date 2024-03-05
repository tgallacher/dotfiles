{
  self,
  config,
  upkgs,
  ...
}: {
  imports = [
    ./apple.nix
    ./battery.nix
    ./calendar.nix
    ./cpu.nix
    ./front_app.nix
    ./network.nix
    ./ram.nix
    ./spaces.nix
    ./vars.nix
  ];

  xdg.configFile."sketchybar/sketchybarrc" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      CONFIG_ROOT=${config.xdg.configHome}/sketchybar
      source $CONFIG_ROOT/vars.sh

      # general bar appearance
      sketchybar --bar \
        height=32 \
        color=$COLOR_BAR \
        shadow=off \
        position=top \
        sticky=on \
        padding_right=15 \
        padding_left=15 \
        topmost=window

      # Setting up default values
      sketchybar --default \
        updates=when_shown \
        icon.font="$NERD_FONT:Bold:14.0" \
        icon.color=$COLOR_DLABEL \
        icon.padding_left=$PADDINGS \
        icon.padding_right=$PADDINGS \
        \
        label.font="$NERD_FONT:Semibold:13.0" \
        label.color=$COLOR_DICON \
        label.highlight=off \
        label.padding_left=$PADDINGS \
        label.padding_right=$PADDINGS \
        \
        padding_right=$PADDINGS \
        padding_left=$PADDINGS \
        \
        background.height=30 \
        background.corner_radius=5 \
        \
        popup.background.border_width=2 \
        popup.background.corner_radius=5 \
        popup.background.border_color=$COLOR_PRIMARY \
        popup.background.color=$COLOR_BAR \
        popup.blur_radius=10 \
        popup.background.shadow.drawing=off

      ## LEFT
      source $CONFIG_ROOT/apple/item.sh
      source $CONFIG_ROOT/spaces/item.sh
      source $CONFIG_ROOT/front_app/item.sh

      # ## CENTER

      # ## RIGHT
      source $CONFIG_ROOT/calendar/item.sh
      source $CONFIG_ROOT/cpu/item.sh
      source $CONFIG_ROOT/ram/item.sh
      source $CONFIG_ROOT/battery/item.sh
      source $CONFIG_ROOT/network/item.sh

      # Forcing all item scripts to run (never do this outside of sketchybarrc)
      sketchybar --update

      echo "sketchybar configuation loaded.."
    '';
  };
}
