{
  self,
  pkgs,
  upkgs,
  config,
  ...
}: let
  alacrittyFileExtension = version:
    if pkgs.lib.versionAtLeast version "0.13"
    then "toml"
    else "yml";
in {
  home.packages = [
    upkgs.alacritty-theme
  ];

  programs.alacritty = {
    enable = true;
    package = upkgs.alacritty;
    # see: https://alacritty.org/config-alacritty.html
    settings = {
      import = [
        "${upkgs.alacritty-theme}/catppuccin_mocha.${alacrittyFileExtension config.programs.alacritty.package.version}"
      ];
      live_config_reload = true;
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        # unfocussed_hollow = true;
        vi_mode_style = {shape = "Underline";};
      };
      colors.draw_bold_text_with_bright_colors = true;
      # fullscreen = false;
      font = {
        size =
          if pkgs.stdenv.isDarwin
          then 14
          else 10;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        # Offset is the extra space around each character. offset.y can be thought of
        # as modifying the linespacing, and offset.x as modifying the letter spacing.
        offset = {
          x = 0;
          y = 0;
        };
        # Glyph offset determines the locations of the glyphs within their cells with
        # the default being at the bottom. Increase the x offset to move the glyph to
        # the right, increase the y offset to move the glyph upward.
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };
      keyboard.bindings =
        []
        ++ (
          if pkgs.stdenv.isDarwin
          then [
            {
              key = "Key3";
              mods = "Alt";
              chars = "#";
            }
          ]
          else []
        ); # Alt + #
      mouse = {
        hide_when_typing = true;
      };
      # save_to_clipboard = true;
      window = {
        dimensions = {
          lines = 30;
          columns = 160;
        };
        padding = {
          x = 4;
          y = 4;
        };
        # Window decorations
        # Setting this to false will result in window without borders and title bar.
        decorations = "full";
        startup_mode = "Windowed";
        dynamic_title = true;
        opacity =
          if pkgs.stdenv.isDarwin
          then 1.0
          else 0.8;
        option_as_alt =
          if pkgs.stdenv.isDarwin
          then "Both"
          else "None";
      };
    };
  };
}
