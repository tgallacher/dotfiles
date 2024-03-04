{
  self,
  config,
  ...
}: {
  xdg.configFile."sketchybar/vars.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Misc
      PADDINGS=3

      # FONTS
      NERD_FONT="JetBrainsMono Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      SKETCHYAPP_FONT="sketchybar-app-font"
      SF_FONT="SF Pro"

      # COLORS
      BG_COLOR=0xff1e1e2e
      BAR_COLOR=0xff1e1e2e
      ITEM_BG_COLOR=0xff585b70
      ACCENT_COLOR=0xffcba6f7

      CYAN=0xff94e2d5
      BLUE=0xff89b4fa
      GREEN=0xff38ba8f
      PEACH=0xffab387f
      RED=0xfff38ba8
      YELLOW=0xff9e2aff
      WHITE=0xffffffff
      TRANSPARENT=0x00000000
    '';
  };
}
