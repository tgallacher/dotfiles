{
  pkgs,
  # upkgs,
  # config,
  ...
}: {
  programs.kitty = {
    enable = false;
    package = pkgs.kitty;
    themeFile = "kanagawa_dragon"; # see https://github.com/kovidgoyal/kitty-themes/tree/master/themes
    shellIntegration.enableZshIntegration = true;
    font = {
      # Needs to be "Fixed Width" font
      # see https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font
      name = "JetBrainsMono NFM";
      size = 13;
    };
    extraConfig = ''
      # Unmap ctl+shift+6 so we get access to ^
      map ctrl+shift+6
      map alt+3           send_text application #

      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono
    '';
    settings = {
      macos_option_as_alt = "both"; # must restart kitty for this to take effect
      macos_quit_when_last_window_closed = "yes";
      hide_window_decorations = "titlebar-only";
      window_margin_width = 5;
    };
  };
}
