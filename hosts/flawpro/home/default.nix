{
  upkgs,
  inputs,
  vars,
  lib,
  ...
}: {
  imports = [
    # inputs.mac-app-util.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    ../../../home/base.nix
    ../../../home/terminal
    ../../../home/nvim
  ];

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine;

  home = {
    username = vars.username;
    homeDirectory = lib.mkForce "/Users/${vars.username}";
    stateVersion = "23.11";
  };

  home.packages = [
    upkgs.raycast
    upkgs.zoom-us
    upkgs.pwgen
  ];

  home.file.".hushlogin".text = ''# silence tty start up spam '';

  # Let Home Manager manage itself (standalone use)
  programs.home-manager.enable = true;
}
