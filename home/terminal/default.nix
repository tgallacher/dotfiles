# Home Manager TERMINAL setup
# Note: Required input params (via `extraSpecialArgs`)
#
# vars, pkgs, upkgs
{
  self,
  vars,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./git.nix
    ./prompt.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = vars.editor;
    TERMINAL = vars.terminal;
    PAGER = "less";
    VISUAL = vars.terminal;
  };
}
