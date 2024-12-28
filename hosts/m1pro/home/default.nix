{
  upkgs,
  inputs,
  vars,
  lib,
  config,
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
  # colorScheme = inputs.nix-colors.colorSchemes.porple;

  home = {
    username = vars.username;
    homeDirectory = lib.mkForce "/Users/${vars.username}";
    stateVersion = "23.11";
  };

  home.packages = [
    upkgs.raycast
    upkgs.zoom-us
    # FIXME: removed in https://github.com/NixOS/nixpkgs/pull/311888
    # upkgs.dbeaver-bin
    upkgs.ansible
    upkgs.pwgen
    upkgs.qmk
    upkgs.utm # VMs
  ];

  home.file.".hushlogin".text = ''# silence tty start up spam '';

  # FIXME: This is too implicit on file layout
  xdg.configFile."aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink ../../../home/files/aerospace.toml;

  # Let Home Manager manage itself (standalone use)
  programs.home-manager.enable = true;
}
