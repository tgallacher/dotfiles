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

  # let nix-darwin inject required sourcing envs to shell
  # see: https://github.com/LnL7/nix-darwin/issues/177#issuecomment-1455055393
  # see: https://xyno.space/post/nix-darwin-introduction
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

  homebrew = {
    enable = true; # allow nix-darwin to manage brew?
    taps = [];
    brews = [];
    casks = [
      "ticktick" # todo
      "brave-browser"
      "spotify"
      "obsidian" # notes
      "discord"
      "1password"
      "1password-cli"
    ];
    masApps = {};
    global = {
      autoUpdate = false;
      brewfile = true; # use the brewfile managed by nix-darwin
    };
    onActivation.cleanup = "zap"; # don't use brew directly, let nix-darwin manage it
  };

  system.activationScripts.postUserActivation.text = ''
    # Auto-apply changed system defaults without having to log out/in
    # source: https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

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

    CustomUserPreferences = {
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true; # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteUSBStores = true;
      };
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      "com.apple.print.PrintingPrefs" = {
        "Quit When Finished" = true; # Automatically quit printer app once the print jobs complete
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # ScheduleFrequency = 1; # Check for software updates daily, not just once per week
        AutomaticDownload = 1; # Download newly available updates in background
        CriticalUpdateInstall = 1; # Install System data files & security updates
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      "com.apple.ImageCapture".disableHotPlug = true; # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.commerce".AutoUpdate = true; # Turn on app auto-update
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
