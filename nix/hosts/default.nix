{ lib, fInputs, nixpkgs, nixpkgs-unstable, home-manager, cVars, ... }:

let
	system = "x86_64-linux";

	pkgs = import nixpkgs {
		inherit system;
		config.allowUnfree = true;
	};

	unstable = import nixpkgs-unstable {
		inherit system;
		config.allowUnfree = true;
	};

	lib = nixpkgs.lib;
in
{
	pn50 = lib.nixosSystem {
		inherit system;
		specialArgs = {
			inherit fInputs system pkgs unstable cVars;
			host = {
				hostName = "pn50";
			};
		};

		modules = [
			./shared.nix
			./pn50
			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
			}
		];
	};
}
