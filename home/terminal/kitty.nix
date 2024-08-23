{
  pkgs,
  upkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = upkgs.kitty;
    theme = "Nightfox";
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      macos_option_as_alt = "both";
      macos_quit_when_last_window_closed = "yes";
      hide_window_decorations = "titlebar-only";
      window_margin_width = 5;
    };
  };
}
