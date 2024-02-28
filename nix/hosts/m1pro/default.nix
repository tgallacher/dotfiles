# TODO: Follow status of - https://github.com/LnL7/nix-darwin/pull/699
{
  self,
  inputs,
  pkgs,
  upkgs,
  config,
  vars,
  ...
}: {
  imports = [
    ../base.nix
    ./system.nix
    ./windowmanager.nix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${vars.username} = import ./home;
      home-manager.extraSpecialArgs = {inherit vars upkgs inputs;};
    }
  ];

  # nix.settings.extra-nix-path = nixpkgs=flake:nixpkgs;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
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
  system.keyboard = {
    enableKeyMapping = true; # enable the following remaps
    remapCapsLockToControl = true;
    swapLeftCommandAndLeftAlt = false;
  };

  # used for backward compatibility. Read the Changelog before editing
  system.stateVersion = 4;

  homebrew = {
    enable = true; # allow nix-darwin to manage brew?
    taps = [];
    brews = [];
    casks = [
      "alacritty"
      "ticktick" # todo
      "brave-browser"
      "spotify"
      "obsidian" # notes
      "discord"
      "1password"
      "1password-cli"
      "whatsapp"
    ];
    masApps = {};
    global.autoUpdate = false;
    global.brewfile = true; # use the brewfile managed by nix-darwin
    onActivation.cleanup = "zap"; # don't use brew directly, let nix-darwin manage it
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
