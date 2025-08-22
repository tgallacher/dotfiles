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
  host.name = "supapro";
  vars =
    args.vars
    // {
      # override
      username = "tomgallacher";
    };
in
  inputs.nix-darwin.lib.darwinSystem {
    specialArgs = {
      inherit inputs vars pkgs upkgs host;
    };

    modules = [
      ../base.nix
      ./supapro.nix
    ];
  }
