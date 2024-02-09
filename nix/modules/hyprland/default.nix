{
  self,
  lib,
  config,
  inputs,
  pkgs,
  upkgs,
  system,
  vars,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
    inputs.home-manager.nixosModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${vars.username} = import ./home;
      home-manager.extraSpecialArgs = {inherit system vars upkgs inputs;};
    }
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # environment.systemPackages = [
  #   upkgs.qt5-wayland
  #   upkgs.qt6-wayland
  # ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  # Allow swaylock to perform authentication
  security.pam.services.swaylock = {};

  services = {
    xserver = {
      enable = false;
      # Disable display managers, as we'll use `greetd`
      displayManager.sddm.enable = false;
      displayManager.gdm.enable = false;
      displayManager.lightdm.enable = false;
      displayManager.xpra.enable = false;
      # Disable desktop managers, as we'll use Hyprland
      desktopManager.plasma5.enable = false;
      desktopManager.xfce.enable = false;
      desktopManager.gnome.enable = false;
      layout = "gb";
    };
    greetd = {
      enable = true;
      package = upkgs.greetd;
      settings = {
        terminal.vt = 1;
        default_session = {
          command = "${lib.getExe config.programs.hyprland.package}";
          user = "${vars.username}";
        };
        # auto login
        # initial_session = "default_session";
      };
    };
  };
}
