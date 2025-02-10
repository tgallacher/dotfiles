# Home Manager TERMINAL setup
{vars, ...}: {
  imports = [
    ./alacritty.nix
    ./wezterm/default.nix
    ./kitty.nix
    ./git.nix
    ./prompt.nix
    ./tmux.nix
    ./wget.nix
    ./zsh.nix
  ];

  # NOTE: vars set at user login
  # need to log out and in if changed
  home.sessionVariables = {};
}
