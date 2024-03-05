{
  self,
  config,
  vars,
  ...
}: {
  xdg.configFile."sketchybar/vars.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ## Misc ##
      PADDINGS=3

      ## FONTS ##
      NERD_FONT="JetBrainsMono Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      SKETCHYAPP_FONT="sketchybar-app-font"
      SF_FONT="SF Pro"

      ## COLORS ##
      COLOR_BAR=0xff${config.colorScheme.palette.base00}
      COLOR_DLABEL=0xff${config.colorScheme.palette.base05} # Default label colour
      COLOR_DICON=0xff${config.colorScheme.palette.base05} # Default icon colour

      COLOR_PRIMARY=0xff${config.colorScheme.palette.base0E}
      COLOR_SECONDARY=0xff${config.colorScheme.palette.base06}
      COLOR_TERTIARY=0xff${config.colorScheme.palette.base07}

      COLOR_SUCCESS=0xff${config.colorScheme.palette.base0B}
      COLOR_ERROR=0xff${config.colorScheme.palette.base08}
      COLOR_WARNING=0xff${config.colorScheme.palette.base0A}
      COLOR_INFORMATION=0xff${config.colorScheme.palette.base09}

      COLOR_WHITE=0xffffffff
      COLOR_TRANSPARENT=0x00000000
    '';
  };
}
