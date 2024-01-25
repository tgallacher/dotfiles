{ self, config, pkgs, pkgs-unstable, vars, ... }:
{
  home.username = vars.username;
  home.homeDirectory = vars.homedir;

  home.packages = [
    pkgs.whatsapp-for-linux
  ];

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
    ".config/alacritty" = {
      source = ../../../alacritty/.config/alacritty;
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
