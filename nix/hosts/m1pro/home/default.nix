{
  self,
  config,
  pkgs,
  upkgs,
  inputs,
  system,
  vars,
  lib,
  ...
}: {
  imports = [
    ../../../../home/base.nix
    ../../../../home/terminal
    ../../../../home/nvim
  ];

  home = {
    username = vars.username;
    homeDirectory = lib.mkForce "/Users/${vars.username}";
    stateVersion = "23.11";
  };

  home.packages = [];

  # Let Home Manager manage itself (standalone use)
  programs.home-manager.enable = true;
}
