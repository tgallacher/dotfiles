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
    sudo.wheelNeedsPassword = false;
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  services = {
    printing.enable = true;
    openssh.enable = true;
  };

  ## Audio
  sound.enable = true;

  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];

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

  users.users.${vars.username} = {
    isNormalUser = true; # automatically set additional settings for normal users
    initialPassword = "Passw0rd!"; # Don't forget to change after initial set up!
    extraGroups = [
      "wheel" #  Enable ‘sudo’
    ];

    extraGroups = [
      "video"
      "audio"
      "networkmanager"
    ];
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     discord = prev.discord.overrideAttrs (_: {
  #       src = builtins.fetchTarball <link-to-tarball>;
  #     });
  #   })
  # ];

  # Do not change. See man configuration.nix or on https://nixos.org/nixos/options.html.
  system.stateVersion = "22.11"; # Did you read the comment?
}
