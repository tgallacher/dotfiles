# TODO: https://github.com/LnL7/nix-darwin/pull/699
{
  pkgs,
  vars,
  host,
  ...
}:
{
  imports = [
    ./system.nix
  ];

  homebrew = {
    enable = true;
    brews = [
      # OS
      "FelixKratz/formulae/borders" # jankyBorders
      "tmux"
      "jackielii/tap/skhd-zig"
      "nixfmt"

      # CORE
      "antidote" # zsh plugin manager
      "tldr"
      "mise" # devtool manager
      "stow"
      "git"
      "dwdiff" # Another diff visualiser
      "curl" # Fetch stuff
      "tldr" # Man docs helper
      "rsync" # File transfer
      "unzip" # Zip files
      "unrar" # Rar files
      "zip" # Zip

      # MISC
      "mtr" # traceroute alternative
      "ykman" # yubikey manager
      "cargo" # (rnix)
      "gcc" # (C compiler)
      "gnumake"
      "rustc"
      "iperf" # Network performance

      # DEPS
      "libiconv" # rnix-lsp
      "pngpaste" # required for Obsidian.nvim
      "trash" # nvim-tree
      {
        # pgsl, pg_dump, etc
        name = "libpq";
        link = true;
      }

      # >supapro
      "libpq" # pqsl cli
      "danielfoehrkn/switch/switch" # kubectx for large scale k8s installations
      "supabase/homebrew-packages/supa-admin-cli"
      "supabase/tap/supabase" # CLI Note: nixpkgs has not been updated to v2 yet

      "ifstat" # sketchybar
      "switchaudio-osx" # volume item; sketchybar
    ];
    casks = [
      # Base
      "brave-browser"
      "mullvad-vpn"
      "obsidian"
      "spotify"
      "whatsapp"
      "raycast"
      "font-monaspace-nerd-font"

      "sf-symbols" # sketchybar
      "font-monaspace"

      # supapro
      "bitwarden"
      "cloudflare-warp"
      "dbeaver-community"
      "discord"
      "front" # support tickets
      "linear-linear" # project management
      "ngrok"
      "notion"
      "orbstack" # Docker desktop alternative
      "slack"
      "yubico-authenticator" # authenticator app
    ];
    global = {
      autoUpdate = false;
    };
  };

  networking.computerName = host.name;
  users.users.${vars.username} = {
    createHome = true;
    home = "/Users/${vars.username}";
    isHidden = false;
  };

  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  # let nix-darwin inject required sourcing envs to shell
  # see: https://github.com/LnL7/nix-darwin/issues/177#issuecomment-1455055393
  # see: https://xyno.space/post/nix-darwin-introduction
  programs.zsh.enable = true;

  # auto upgrade the daemon service
  services.nix-daemon.enable = true;

  # used for backward compatibility. Read the Changelog before editing
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
