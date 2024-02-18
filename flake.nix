{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, ...} @ inputs: let
    vars = {
      username = "tgallacher";
      terminal = "alacritty";
      editor = "nvim";
    };
  in {
    homeConfigurations = {
      pn50 = inputs.home-manager.lib.homeManagerConfiguration {
        # "${vars.username}@pn50" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          ./nix/hosts/pn50/home
        ];

        extraSpecialArgs = {
          inherit inputs vars;
          upkgs = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
      };

      m1pro = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-darwin";
          config = {allowUnfree = true;};
        };

        modules = [
          ./nix/hosts/m1pro/home
        ];

        extraSpecialArgs = {
          inherit inputs vars;
          upkgs = import inputs.nixpkgs-unstable {
            system = "aarch64-darwin";
            config = {allowUnfree = true;};
          };
        };
      };
    };

    nixosConfigurations = (
      import ./nix/hosts {
        inherit (inputs.nixpkgs) lib;
        inherit inputs vars;
      }
    );

    darwinConfigurations = {
      m1pro = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs vars;

          host = {
            name = "m1pro";
          };

          pkgs = import inputs.nixpkgs {
            system = "aarch64-darwin";
            config = {allowUnfree = true;};
          };
          upkgs = import inputs.nixpkgs-unstable {
            system = "aarch64-darwin";
            config = {allowUnfree = true;};
          };
        };

        modules = [
          ./nix/hosts/m1pro
        ];
      };
    };
  };
}
