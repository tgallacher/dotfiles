{
  lib,
  pkgs,
  upkgs,
  inputs,
  system,
  vars,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = ["amdgpu"];
  };

  hardware = {
    # opengl = {};
    bluetooth.enable = true;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # environment = {
  #   systemPackages = with pkgs; [
  #   ] ++ (with pkgs-unstable; [
  #   ]);
  # };

  services = {
    xserver = {
      enable = false;
      # displayManager.sddm.enable = true;
      # desktopManager.plasma5.enable = true;
      layout = "gb";
    };
    greetd = let
      session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "${vars.username}";
      };
    in {
      enable = true;
      vt = 1;
      package = upkgs.greetd;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     discord = prev.discord.overrideAttrs (_: {
  #       src = builtins.fetchTarball <link-to-tarball>;
  #     });
  #   })
  # ];
}
