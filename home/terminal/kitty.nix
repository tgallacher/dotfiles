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
    '';
    settings = {
      macos_option_as_alt = "both"; # must restart kitty for this to take effect
      macos_quit_when_last_window_closed = "yes";
      hide_window_decorations = "titlebar-only";
      window_margin_width = 5;
    };
  };
}
