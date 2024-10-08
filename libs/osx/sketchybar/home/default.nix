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
    ./volume.nix
    ./wifi.nix
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
        color="$COLOR_BAR" \
        shadow=off \
        position=top \
        sticky=on \
        padding_right=10 \
        padding_left=10 \
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
        background.corner_radius="$RADIUS" \
        \
        popup.background.border_width=1 \
        popup.background.corner_radius="RADIUS" \
        popup.background.border_color="$COLOR_PRIMARY" \
        popup.background.color="$COLOR_BAR" \
        popup.blur_radius=10 \
        popup.background.shadow.drawing=off

      ## LEFT
      source $CONFIG_ROOT/apple/item.sh
      source $CONFIG_ROOT/spaces/item.sh
      source $CONFIG_ROOT/front_app/item.sh

      # ## CENTER

      # ## RIGHT
      source $CONFIG_ROOT/calendar/item.sh
      source "$CONFIG_ROOT/wifi/item.sh"
      source $CONFIG_ROOT/battery/item.sh
      source $CONFIG_ROOT/volume/item.sh

      sketchybar \
        --add item spacer right \
        --set spacer \
        background.drawing=off \
        width=8

      source $CONFIG_ROOT/ram/item.sh
      source $CONFIG_ROOT/cpu/item.sh
      source $CONFIG_ROOT/network/item.sh

      bracket_style=(
        background.height=24
        background.drawing=off
        background.color="$COLOR_TRANSPARENT"
        background.border_color="$COLOR_TRANSPARENT"
        background.border_width=1
        background.corner_radius="$RADIUS"
        blur_radius=32
      )

      sketchybar \
        --add bracket workspaces_block apple.logo "/space\..*/" space_separator front_app \
        --set workspaces_block "''${bracket_style[@]}" \
        \
        --add bracket status_block "/network\..*/" cpu memory \
        --set status_block "''${bracket_style[@]}" \
        \
        --add bracket osx_basic volume volume_icon battery wifi date clock \
        --set osx_basic "''${bracket_style[@]}"

      # Forcing all item scripts to run (never do this outside of sketchybarrc)
      sketchybar --update

      echo "sketchybar configuation loaded.."
    '';
  };
}
