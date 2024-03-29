# Home Manager TERMINAL setup
{vars, ...}: {
  imports = [
    ./alacritty.nix
    ./git.nix
    ./prompt.nix
    ./tmux.nix
    ./wget.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = vars.editor;
    TERMINAL = vars.terminal;
    PAGER = "less";
    VISUAL = vars.terminal;
  };
}
