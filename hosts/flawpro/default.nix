args: let
  system = "aarch64-darwin";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {allowUnfree = true;};
  };
  upkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config = {allowUnfree = true;};
  };

  inputs = args.inputs;
  host.name = "tgallacher-flawpro";
  vars =
    args.vars
    // {
      username = "tom.gallacher";
    };
in
  inputs.nix-darwin.lib.darwinSystem {
    specialArgs = {
      inherit inputs vars pkgs upkgs host;
    };

    modules = [
      ../base.nix
      ./flawpro.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${vars.username} = import ./home;
        home-manager.extraSpecialArgs = {inherit vars upkgs inputs host;};
      }
    ];
  }
