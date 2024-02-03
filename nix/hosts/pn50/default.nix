{
  lib,
  inputs,
  vars,
  ...
}: let
  inherit (inputs) home-manager nixvim;
  system = "x86_64-linux";

  pkgs = import inputs.nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  upkgs = import inputs.nixpkgs-unstable {
    inherit system;

    config = {
      allowUnfree = true;
      # Obsidian is lagging way behind ElectronJS LTS
      # see: https://github.com/NixOS/nixpkgs/issues/273611#issuecomment-1858755633
      permittedInsecurePackages = lib.optional (upkgs.obsidian.version == "1.5.3") "electron-25.9.0";
    };
  };
in
  lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit lib inputs system pkgs upkgs vars;
      host = {
        name = "pn50";
      };
    };

    modules = [
      ../../modules/hyprland
      ../shared.nix
      ./pn50.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${vars.username} = import ./home;
        home-manager.extraSpecialArgs = {inherit system vars upkgs inputs;};
      }
    ];
  }
