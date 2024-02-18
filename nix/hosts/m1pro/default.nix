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
    # createHome = true;
    # home = "/Users/${vars.username}";
    isHidden = false;
  };

  # see: https://github.com/LnL7/nix-darwin/issues/177#issuecomment-1455055393
  programs.zsh.enable = true;

  # auto upgrade the daemon service
  services.nix-daemon.enable = true;

  # used for backward compatibility. Read the Changelog before editing
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
