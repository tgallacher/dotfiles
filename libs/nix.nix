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
      # TODO: need to move .profile. See `man 5 nix.conf`
      # use-xdg-base-directories = true;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      ## Determinate System Installer settings
      extra-nix-path = "nixpkgs=flake:nixpkgs";
      # FIXME: Unknown options?
      # upgrade-nix-store-path-url = "https://install.determinate.systems/nix-upgrade/stable/universal";
      # always-allow-substitutes = true;
      bash-prompt-prefix = "(nix:$name)\040";
      extra-trusted-substituters = "https://cache.flakehub.com";
      extra-trusted-public-keys = [
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
      ];
      ## /end
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
