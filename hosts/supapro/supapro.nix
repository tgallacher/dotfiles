# TODO: https://github.com/LnL7/nix-darwin/pull/699
{
  pkgs,
  vars,
  host,
  ...
}: {
  imports = [
    ./system.nix
    # ./windowmanager.nix
    # ../../libs/osx/sketchybar
  ];

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
