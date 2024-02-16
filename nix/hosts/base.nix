# base.nix
#   Set a common baseline for each non-server computer
{
  lib,
  pkgs,
  upkgs,
  inputs,
  vars,
  config,
  host,
  ...
}: {
  imports = [
    ../libs/nix.nix
  ];

  i18n.defaultLocale = "en_GB.UTF-8";
  networking.hostName = host.name;
  time.timeZone = "Europe/London";

  services = {
    printing.enable = true;

    openssh = {
      enable = true;
    };
  };

  ## Audio
  sound.enable = true;

  # List packages installed in system profile.
  # To search, run: `$ nix search <pacakge_name>`
  environment.systemPackages = [];

  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];

  users.users.${vars.username} = {
    isNormalUser = true; # automatically set additional settings for normal users
    initialPassword = "Passw0rd!"; # Don't forget to change after initial set up!
    shell = upkgs.zsh;
    extraGroups = [
      "wheel" #  Enable ‘sudo’
    ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };
}
