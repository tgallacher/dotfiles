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
      "devspace" # dev tool for interating on k8s apps
      "docker" # cli / deamen only
      "eksctl"
      "eza" # `ls` replacement
      "flock" # file locking
      "gh" # Github CLI
      "jwt-cli"
      "k9s"
      "kind" # local k8s
      "kubectl"
      "kubectx"
      "libiconv" # rnix-lsp
      "minikube"
      "mtr" # traceroute alternative
      "nvm" # nodejs version manager
      "protoc-gen-go" # protobuf tooling
      "protoc-gen-go-grpc" # protobuf tooling
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
      "aws-vault" # dev secrets management
      "bitwarden"
      "brave-browser"
      "cloudflare-warp"
      "dbeaver-community" # nixpkgs version has been removed; see https://github.com/NixOS/nixpkgs/pull/311888
      "discord"
      "front" # support tickets
      "linear-linear" # project management
      "mullvad-vpn"
      "ngrok"
      "notion"
      "obsidian"
      "orbstack" # Docker desktop alternative
      "raycast"
      "slack"
      "spotify"
      "whatsapp"
      "yubico-authenticator" # authenticator app; INFO: nixpkgs is linux only
    ];
    masApps = {};
    global.autoUpdate = false;
    global.brewfile = true; # use the brewfile managed by nix-darwin
    onActivation.cleanup = "zap"; # don't use brew directly, let nix-darwin manage it
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
