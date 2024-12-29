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

  # nix.settings.extra-nix-path = nixpkgs=flake:nixpkgs;

  networking.computerName = host.name;

  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji # see "michaelrommel/nvim-silicon"
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
    ];
    brews = [
      "libiconv" # rnix-lsp
      "trash" # nvim-tree
      "borders" # jankyBorders
      "silicon" # see "michaelrommel/nvim-silicon"; barage of errors if installed from nixpkgs
      "gh" # Github CLI
    ];
    casks = [
      "ticktick" # todo
      "brave-browser"
      "spotify"
      "obsidian" # notes
      "discord"
      "1password"
      "1password-cli"
      "whatsapp"
      # "spacelauncher"
      # "docker"
      "orbstack" # docker desktop alternative
      "postman" # nixpkgs version seems to be down; use brew instead
      "dbeaver-community" # nixpkgs version has been removed; see https://github.com/NixOS/nixpkgs/pull/311888
      "bambu-studio"
    ];
    masApps = {};
    global.autoUpdate = false;
    global.brewfile = true; # use the brewfile managed by nix-darwin
    onActivation.cleanup = "zap"; # don't use brew directly, let nix-darwin manage it
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
