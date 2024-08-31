{config, ...}: {
  xdg.configFile."sketchybar/vars.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ## Misc ##
      PADDINGS=3
      RADIUS=0

      ## FONTS ##
      NERD_FONT="JetBrainsMono Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      SKETCHYAPP_FONT="sketchybar-app-font"
      SF_FONT="SF Pro"

      ## COLORS ##
      getOpacity() {
        opacity=$1

        local o100=0xff
        local o75=0xbf
        local o50=0x80
        local o25=0x40
        local o10=0x1a
        local o0=0x00

        case $opacity in
        75) local opacity=$o75 ;;
        50) local opacity=$o50 ;;
        25) local opacity=$o25 ;;
        10) local opacity=$o10 ;;
        0) local opacity=$o0 ;;
        *) local opacity=$o100 ;;
        esac

        echo "$opacity"
      }

      COLOR_BAR="$(getOpacity 75)${config.colorScheme.palette.base00}"
      COLOR_BG=0xff${config.colorScheme.palette.base02}
      COLOR_DLABEL=0xff${config.colorScheme.palette.base05} # Default label colour
      COLOR_DICON=0xff${config.colorScheme.palette.base05} # Default icon colour

      COLOR_PRIMARY=0xff${config.colorScheme.palette.base0E} # mauve
      COLOR_SECONDARY=0xff${config.colorScheme.palette.base06} # rosewater
      COLOR_TERTIARY=0xff${config.colorScheme.palette.base07} # lavendar

      COLOR_SUCCESS=0xff${config.colorScheme.palette.base0B}
      COLOR_ERROR=0xff${config.colorScheme.palette.base08}
      COLOR_WARNING=0xff${config.colorScheme.palette.base0A}
      COLOR_INFORMATION=0xff${config.colorScheme.palette.base0C}

      COLOR_WHITE=0xffffffff
      COLOR_TRANSPARENT=0x00000000
    '';
  };
}
