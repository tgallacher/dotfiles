{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, vars, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  pkgs-unstable = import nixpkgs-unstable {
    inherit system;

    config = {
      allowUnfree = true;
      # Obsidian is lagging way behind ElectronJS LTS
      # see: https://github.com/NixOS/nixpkgs/issues/273611#issuecomment-1858755633 
      permittedInsecurePackages = lib.optional (pkgs-unstable.obsidian.version == "1.5.3") "electron-25.9.0";
    };
  };
in

lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit lib home-manager inputs system pkgs pkgs-unstable vars;
    host = {
      name = "pn50";
    };
  };

  modules = [
    ../shared.nix
    ./pn50.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${vars.username} = import ./home.nix;
      home-manager.extraSpecialArgs = { inherit vars pkgs-unstable; };
    }
  ];
}
