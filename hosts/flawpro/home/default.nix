{
  upkgs,
  pkgs,
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
    # (
    #   {self, ...}: {
    #     nixpkgs.overlays = [
    #       (final: prev: {
    #         git = final.git.override {
    #           userEmail = "173261044+tomg-flwls@users.noreply.github.com";
    #         };
    #       })
    #     ];
    #   }
    # )
    {
      programs.git.userEmail = lib.mkForce "173261044+tomg-flwls@users.noreply.github.com";
    }
  ];

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine;

  home = {
    username = vars.username;
    homeDirectory = lib.mkForce "/Users/${vars.username}";
    stateVersion = "23.11";
  };

  home.packages = [
    upkgs.raycast
    upkgs.pwgen
    # FIXME: require >0.30 to fix terminal killer bug
    # Use brew for now...
    # upkgs.granted # simplified cloud account switching
    upkgs.awscli2
    upkgs.temporal-cli
    upkgs.bitwarden-cli # desktop app installed via brew

    # Python
    upkgs.uv # pip replacement + more
    pkgs.poetry # pip replacement
    pkgs.poethepoet # task runner for poetry
  ];

  home.file.".hushlogin".text = ''# silence tty start up spam '';

  # Let Home Manager manage itself (standalone use)
  programs.home-manager.enable = true;
}
