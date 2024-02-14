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
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      # Neovim/Mason dep.

      nodejs_20 # Also req. for Neovim/Mason
      cargo # (rnix)
      terraform # (terraform-fmt)
      coreutils # (C utils)
      gcc # (C compiler)
      gnumake
      pyenv
      alejandra # Nix formatter
      # stylua # Nix formatter

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
      iperf # Network performance
      ranger # File manager
      w3m # img preview in ranger
      tldr # Man docs helper
      # Audio/Video

      vlc # Media player
      # File Management

      rsync # File transfer
      unzip # Zip files
      unrar # Rar files
      zip # Zip
      ;

    inherit
      (upkgs)
      # CLIs

      home-manager # Nix home dir manaager
      python3
      # Apps

      _1password-gui # Secrets
      brave # Web browser
      discord # chat
      obsidian # notetaking
      spotify # music
      ticktick # todos
      ;
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
    isNormalUser = true; # automatically set additional settings for normal users
    initialPassword = "Passw0rd!"; # Don't forget to change after initial set up!
    shell = upkgs.zsh;
    extraGroups = [
      "wheel" #  Enable ‘sudo’
      "video"
      "audio"
      "networkmanager"
    ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  # Do not change. See  man configuration.nix or on https://nixos.org/nixos/options.html.
  system.stateVersion = "22.11"; # Did you read the comment?
}
