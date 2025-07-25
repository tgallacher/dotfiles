{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    # see: https://github.com/nix-community/home-manager/issues/1341#issuecomment-1821526984
    # mac-app-util.url = "github:hraban/mac-app-util"; # Fix Application link / spotlight, etc
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    vars = {
      username = "tgallacher";
      terminal = "ghostty";
      editor = "nvim";
    };
  in {
    # TODO: Consider removing this, as not all HOME stuff is configured through HM
    homeConfigurations = {
      pn50 = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          ./hosts/pn50/home
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
          ./hosts/m1pro/home
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
      import ./hosts {
        inherit inputs vars;
      }
    );

    darwinConfigurations = (
      import ./hosts {
        inherit inputs vars;
      }
    );
  };
}
