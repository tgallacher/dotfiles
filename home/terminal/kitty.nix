{
  pkgs,
  upkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = upkgs.kitty;
    # themeFile = "Gnome-ish_gray-on-black";
    themeFile = "kanagawa_dragon"; # see https://github.com/kovidgoyal/kitty-themes/tree/master/themes
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "JetBrainsMono";
      size = 13;
    };
    extraConfig = ''
      map ctrl+shift+6
      map alt+3           send_text application #

      # ## FIXME: Tmux extended keys bug workaround
      # #  see: https://github.com/tmux/tmux/issues/2705#issuecomment-1373880039
      # # Ctrl 0 - 9
      # map ctrl+0 send_text all \x1b[48;5u
      # map ctrl+1 send_text all \x1b[49;5u
      # map ctrl+2 send_text all \x1b[50;5u
      # map ctrl+3 send_text all \x1b[51;5u
      # map ctrl+4 send_text all \x1b[52;5u
      # map ctrl+5 send_text all \x1b[53;5u
      # map ctrl+6 send_text all \x1b[54;5u
      # map ctrl+7 send_text all \x1b[55;5u
      # map ctrl+8 send_text all \x1b[56;5u
      # map ctrl+9 send_text all \x1b[57;5u
      #
      # # Ctrl + . , ;
      # map ctrl+. send_text all \x1b[46;5u
      # map ctrl+, send_text all \x1b[44;5u
      # map ctrl+; send_text all \x1b[59;5u
      #
      # # Shift + Enter
      # map shift+enter send_text all \x1b[13;2u
      #
      # # Ctrl + I & Ctrl + M Remaps
      # map ctrl+i send_text all \x1b[105;5u
      # map ctrl+m send_text all \x1b[109;5u
      #
      # # Ctrl + Shift Remaps
      # map ctrl+shift+h send_text all \x1b[72;6u
      # map ctrl+shift+j send_text all \x1b[74;6u
      # map ctrl+shift+k send_text all \x1b[75;6u
      # map ctrl+shift+l send_text all \x1b[76;6u
      #
      # map ctrl+shift+u send_text all \x1b[117;6u
      # map ctrl+shift+o send_text all \x1b[111;6u
      # map ctrl+shift+p send_text all \x1b[112;6u
      #
      # map ctrl+shift+s send_text all \x1b[108;6u
    '';
    settings = {
      macos_option_as_alt = "both"; # must restart kitty for this to take effect
      macos_quit_when_last_window_closed = "yes";
      hide_window_decorations = "titlebar-only";
      window_margin_width = 5;
    };
  };
}
