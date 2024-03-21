{
  self,
  pkgs,
  ...
}: {
  nix = {
    # FIXME: see https://github.com/nix-community/home-manager/issues/4692
    # package = upkgs.nixVersions.unstable;
    # package = pkgs.nixVersions.stable;
    settings = {
      # need to move .profile. See `man 5 nix.conf`
      # use-xdg-base-directories = true;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc =
      {
        automatic = true;
        options = "--delete-older-than 7d";
      }
      // (
        if pkgs.stdenv.isDarwin
        then {
          # interval = "weekly";
        }
        else {
          dates = "weekly";
        }
      );
  };
}
