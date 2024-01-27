{ lib, pkgs, upkgs, inputs, vars, config, host, ... }:

{
  #	imports = (
  #		import ../modules/?.nix
  #	);

  nix = {
    # FIXME: see https://github.com/nix-community/home-manager/issues/4692
    # package = upkgs.nixVersions.unstable;
    package = pkgs.nixVersions.stable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    # gc = {
    # 	automatic = true;
    #       dates = "weekly";
    #       options = "--delete-older-than 7d";
    # };
  };

  networking = {
    # Note: Pick only one of the below networking options.
    # wireless.enable = true;  		# Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    hostName = host.name;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    printing.enable = true;

    openssh = {
      enable = true;
      #	allowSFTP = true;
      #	extraConfig = ''
      #		HostKeyAlgorithms +ssh-rsa
      #	'';
    };
  };

  ## Audio
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = false;


  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # List packages installed in system profile.
  # To search, run: `$ nix search <pacakge_name>`
  environment = {
    # variables = { };

    systemPackages = with pkgs; [
      nodejs_20 # Also req. for Neovim/Mason
      cargo # Neovim/Mason dep. (rnix)
      terraform # Neovim/Mason dep. (terraform-fmt)
      nixpkgs-fmt # Neovim/Mason dep. (rnix)
      coreutils # Neovim/Mason dep. (C utils)
      gcc # Neovim/Mason dep. (C compiler)
      gnumake # Neovim dep.
      pyenv


      # CLI
      btop # Resource manager
      bat # cat with wings
      curl # Fetch stuff
      difftastic # Diff visualiser
      direnv # Dynamic shell configs
      dwdiff # Another diff visualiser
      fzf # Find stuff (also dep. of Neovim/Telescope)
      git # Version control
      glib # require GIO for NvimTree
      home-manager # Nix home dir manaager
      iperf # Network performance
      neovim # The only editor
      tmux # Terminal super powers
      ranger # File manager
      tldr # Man docs helper

      # Audio/Video
      alsa-utils # Audio control
      feh # Image viewer
      mpv # Media player
      pipewire # Audio server/control
      pulseaudio # Audio server/control
      vlc # Media player

      # File Management
      okular # PDF viewer
      p7zip # File encryption
      rsync # File transfer
      unzip # Zip files
      unrar # Rar files
      zip # Zip
    ] ++
    (with upkgs; [
      # CLIs
      python3

      # Apps
      _1password-gui # Secrets
      brave # Web browser
      discord # chat
      obsidian # notetaking
      spotify # music
      ticktick # todos
    ]);
  };

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

  users.users.${vars.username} = {
    shell = upkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; # "wheel" -> Enable ‘sudo’ for the user.
    initialPassword = "Passw0rd!"; # Don't forget to change after initial set up!
    isNormalUser = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
