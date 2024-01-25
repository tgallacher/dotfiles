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
      vars = rec {
        username = "tgallacher";
        homedir = "/home/${vars.username}";
        # FIXME: stdenv not found
        # if nixpkgs.stdenv.isDarwin
        # then "/users/${vars.username}"
        # else "/home/${vars.username}";
        terminal = "alacritty";
        editor = "nvim";
      };
    in
    {
      # homeConfigurations = (
      #   import ./nix/modules/home {
      #     # inherit (nixpkgs) lib;
      #     inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
      #   }
      # );
      nixosConfigurations = (
        import ./nix/hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
        }
      );
    };
}
