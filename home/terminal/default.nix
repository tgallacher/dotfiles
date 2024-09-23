# Home Manager TERMINAL setup
{vars, ...}: {
  imports = [
    ./alacritty.nix
    # ./wezterm/default.nix
    ./kitty.nix
    ./git.nix
    ./prompt.nix
    ./tmux.nix
    ./wget.nix
    ./zsh.nix
  ];

  # NOTE: vars set at user login
  home.sessionVariables = {
    EDITOR = vars.editor;
    TERMINAL = vars.terminal;
    PAGER = "less";
    VISUAL = vars.terminal;
  };
}
