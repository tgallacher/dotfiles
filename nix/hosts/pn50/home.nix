{ self, config, pkgs, pkgs-unstable, vars, ... }:
{
  home.username = vars.username;
  home.homeDirectory = vars.homedir;

  home.packages = [
    pkgs.whatsapp-for-linux
  ];

  programs = {
    alacritty = {
      enable = true;
      package = pkgs-unstable.alacritty;
      # see: https://alacritty.org/config-alacritty.html
      settings = {
        import = [ "~/.config/alacritty/themes/themes/github_dark_default.yaml" ];
        cursor = {
          style = {
            shape = "Block";
            blinking = "on";
            vi_mode_style = "on";
            unfocussed_hollow = true;
          };
          vi_mode_style = { shape = "Underline"; };
        };
        draw_bold_text_with_bright_colors = true;
        fullscreen = false;
        font = {
          size = 10;
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
            style = "Bold";
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
        key_bindings = [
          { key = "Key3"; mods = "Alt"; chars = "#"; } # Alt + #
        ];
        mouse = {
          hide_when_typing = true;
        };
        save_to_clipboard = true;
        window = {
          dimensions = { lines = 3; columns = 3; };
          padding = { x = 4; y = 4; };
          # Window decorations
          # Setting this to false will result in window without borders and title bar.
          decorations = "full";
          startup_mode = "Windowed";
          dynamic_title = true;
          opacity = 1.0;
        };
      };
    };
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        end_of_line = "lf";
        indent_size = 2;
        charset = "utf-8";
      };
    };
  };

  # Manage Dotfiles
  home.file = {
    ".alacritty/themes" = {
      source = ../../../alacritty/.config/alacritty/themes;
      recursive = true;
    };
    ".config/git" = {
      source = ../../../git/.config/git;
      recursive = true;
    };
    # TODO: Better way to get flake location?
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${vars.homedir}/Code/${vars.username}/dotfiles/nvim/.config/nvim";
    ".config/tmux/tmux.conf".source = ../../../tmux/.config/tmux/tmux.conf;
    ".zshenv".source = ../../../zsh/.zshenv;
    ".config/zsh" = {
      source = ../../../zsh/.config/zsh;
      recursive = true;
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
