# TODO: Follow status of - https://github.com/LnL7/nix-darwin/pull/699
{
  self,
  inputs,
  pkgs,
  upkgs,
  config,
  vars,
  ...
}: {
  imports = [
    ../base.nix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${vars.username} = import ./home;
      home-manager.extraSpecialArgs = {inherit vars upkgs inputs;};
    }
  ];

  # nix.settings.extra-nix-path = nixpkgs=flake:nixpkgs;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };

  users.users.${vars.username} = {
    # createHome = true;
    # home = "/Users/${vars.username}";
    isHidden = false;
  };

  # see: https://github.com/LnL7/nix-darwin/issues/177#issuecomment-1455055393
  programs.zsh.enable = true;

  # auto upgrade the daemon service
  services.nix-daemon.enable = true;
  system.keyboard = {
    enableKeyMapping = true; # enable the following remaps
    remapCapsLockToControl = true;
    swapLeftCommandAndLeftAlt = false;
  };

  # used for backward compatibility. Read the Changelog before editing
  system.stateVersion = 4;

  system.defaults = {
    dock = {
      autohide = false;
      minimize-to-application = false;
      mru-spaces = false;
      orientation = "bottom"; # bottom | left | right
      show-recents = false;
      static-only = true; # only show open applications in dock
      tilesize = 32;
      magnification = true;
      largesize = 128;
    };
    finder = {
      ShowStatusBar = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
      FXDefaultSearchScope = "SCcf"; # current folder
    };
    loginwindow.GuestEnabled = false;
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5 * 60; # secs
    };
    trackpad = {
      Clicking = true; # tap to clik
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowAMPM = false;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowDate = 0; # 0 - show; 1 - don't show
      ShowSeconds = false;
    };
    screencapture = {
      # location = "${config.home.homeDirectory}/Desktop";
      type = "jpg";
      disable-shadow = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "WhenScrolling";
      AppleKeyboardUIMode = 3; # keyboard control over OSX UI; 0 - tab in modal dialogs; 2/3 = all controls
      ApplePressAndHoldEnabled = false; # diasable in favour of key-repeat

      # Set fast key repeat
      InitialKeyRepeat = 20;
      KeyRepeat = 1;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false; # PITA with coding
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      NSAutomaticDashSubstitutionEnabled = false; # PITA with coding
      NSDocumentSaveNewDocumentsToCloud = false;
      NSTableViewDefaultSizeMode = 2; # finder sidebar icon size: 1,2,3
      "com.apple.keyboard.fnState" = false; # use Fn keys are normal F1, F2, ...
      "com.apple.mouse.tapBehavior" = 1; # 1, null: trackpad tap to click enablbed when "1"
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.swipescrolldirection" = false; # set natural scrolling direction
      AppleMetricUnits = 1;
      AppleICUForce24HourTime = true; # 24 hr clock
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
