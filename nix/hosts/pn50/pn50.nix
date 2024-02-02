{
  lib,
  pkgs,
  upkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
  ];

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
      enable = true;
      # displayManager.sddm.enable = true;
      # desktopManager.plasma5.enable = true;
      layout = "gb";
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
