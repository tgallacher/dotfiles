{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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
    bluetooth.enable = true;
  };

  networking = {
    # Note: Pick only one of the below networking options.
    # wireless.enable = true;  		# Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Audio/Video
    alsa-utils # Audio control
    feh # Image viewer
    mpv # Media player
    pipewire # Audio server/control
    pulseaudio # Audio server/control

    # File Management
    okular # PDF viewer
    p7zip # File encryption
    xfce.thunar # File manager
    xfce.thunar-volman # Extension to add support for removable drives/media

    thunderbird
  ];

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     discord = prev.discord.overrideAttrs (_: {
  #       src = builtins.fetchTarball <link-to-tarball>;
  #     });
  #   })
  # ];
}
