{ self, config, vars, ... }:
{
  # Manage Dotfiles
  # home-manager.users.${vars.username} = {
  home.file = {
    ".config/alacritty" = {
      source = ../../../alacritty/.config/alacritty;
      recursive = true;
    };
    ".config/git" = {
      source = ../../../git/.config/git;
      recursive = true;
    };
    # FIXME: Better way to get flake location?
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "~/Code/${vars.username}/dotfiles/nvim/.config/nvim";
    ".config/tmux/tmux.conf".source = ../../../tmux/.config/tmux/tmux.conf;
    ".zshenv".source = ../../../zsh/.zshenv;
    ".config/zsh" = {
      source = ../../../zsh/.config/zsh;
      recursive = true;
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
  # };
}
