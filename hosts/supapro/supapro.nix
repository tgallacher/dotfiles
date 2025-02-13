# TODO: https://github.com/LnL7/nix-darwin/pull/699
{
  pkgs,
  vars,
  host,
  ...
}: {
  imports = [
    ./system.nix
    ./windowmanager.nix
    ../../libs/osx/sketchybar
  ];

  networking.computerName = host.name;

  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };

  users.users.${vars.username} = {
    createHome = true;
    home = "/Users/${vars.username}";
    isHidden = false;
  };

  # let nix-darwin inject required sourcing envs to shell
  # see: https://github.com/LnL7/nix-darwin/issues/177#issuecomment-1455055393
  # see: https://xyno.space/post/nix-darwin-introduction
  programs.zsh.enable = true;

  # auto upgrade the daemon service
  services.nix-daemon.enable = true;

  # used for backward compatibility. Read the Changelog before editing
  system.stateVersion = 4;

  homebrew = {
    enable = true; # allow nix-darwin to manage brew?
    taps = [
      "FelixKratz/formulae" # jankyBorders
      "common-fate/granted" # simplified cloud account switching
      "mike-engel/jwt-cli"
      "openfga/tap"
      "pulumi/tap" # IaC
      "supabase/tap" # CLI
    ];
    brews = [
      "bitwarden-cli"
      "borders" # jankyBorders
      "common-fate/granted/granted" # aws profile switcher
      "dbmate" # database migration tool / cli
      "docker" # cli / deamen only
      "eksctl"
      "flock" # file locking
      "gh" # Github CLI
      "jwt-cli"
      "k9s"
      "kubectl"
      "kubectx"
      "libiconv" # rnix-lsp
      "minikube"
      "nvm" # nodejs version manager
      "pulumi"
      "supabase" # CLI Note: nixpkgs has not been updated to v2 yet
      "supabase/homebrew-packages/supa-admin-cli"
      "trash" # nvim-tree
      "ykman" # yubikey manager
      {
        # pqsl cli
        name = "libpq";
        link = true;
      }
    ];
    casks = [
      "aptakube"
      "aws-vault" # dev secrets management
      "bitwarden"
      "brave-browser"
      "dbeaver-community" # nixpkgs version has been removed; see https://github.com/NixOS/nixpkgs/pull/311888
      "discord"
      "linear-linear" # project management
      "ngrok"
      "notion"
      "obsidian"
      "orbstack" # Docker desktop alternative
      "raycast"
      "slack"
      "spotify"
      "yubico-authenticator" # authenticator app; NOTE: nixpkgs is linux only
      # "postman" # NOTE: nixpkgs version seems to be down; use brew instead
    ];
    masApps = {};
    global.autoUpdate = false;
    global.brewfile = true; # use the brewfile managed by nix-darwin
    onActivation.cleanup = "zap"; # don't use brew directly, let nix-darwin manage it
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
