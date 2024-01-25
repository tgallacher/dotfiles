{ lib, pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware = {
    # opengl = {};
    bluetooth.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      whatsapp-for-linux
    ] ++ (with pkgs-unstable; [
      # whatsapp-for-linux
    ]);
  };


  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
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
