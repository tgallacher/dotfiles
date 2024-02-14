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
        modules = [./nix/hosts/pn50/home];
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs vars;
          upkgs = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
      };
    };

    nixosConfigurations = (
      import ./nix/hosts {
        inherit (inputs.nixpkgs) lib;
        inherit inputs vars;
      }
    );
  };
}
