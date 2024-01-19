{
  description = "NixOS Flake config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @inputs:
    let
      vars = {
        username = "tgallacher";
        terminal = "alacritty";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = (
        import ./nix/hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
        }
      );
    };
}
