# If you want to figure out what default needs changing, do the following:
#
#   1. `cd /tmp`
#   2. Store current defaults in file: `defaults read > before`
#   3. Make a change to your system.
#   4. Store new defaults in file: `defaults read > after`
#   5. Diff the files: `diff before after`
#
# @see: http://secrets.blacktree.com/?showapp=com.apple.finder
# @see: https://github.com/herrbischoff/awesome-macos-command-line
{
  config,
  vars,
  ...
}: let
  homeDir = config.home-manager.users.${vars.username}.home.homeDirectory;
in {
  system.activationScripts.postUserActivation.text = ''
    # Auto-apply changed system defaults without having to log out/in
    # source: https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # FIXME: This doesn't seem to work; need to investigate
  # # /usr/bin/osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"${homeDir}/Code/tgallacher/dotfiles/wallpapers/bg_5.jpg\" as POSIX file"
  # system.activationScripts.extraActivation.text = ''
  #   # Set wallpaper
  #   /usr/bin/osascript -e 'tell application "Finder" to activate and to set desktop picture to POSIX file "${homeDir}/Code/tgallacher/dotfiles/wallpapers/bg_5.jpg"'
  # '';

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
      # # remove delay for showing dock
      # autohide-delay = 0.0;
      # launchanim = false;
      # showhidden = true;
      # show-process-indicators = true;
      # mouse in top right corner will (5) start screensaver
      wvous-tr-corner = 5;
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
      location = "${homeDir}/Desktop";
      type = "jpg";
      disable-shadow = true;
    };
    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = false; # use Fn keys are normal F1, F2, ...
      "com.apple.mouse.tapBehavior" = 1; # 1, null: trackpad tap to click enabled when "1"
      "com.apple.swipescrolldirection" = false; # set natural scrolling direction
      "com.apple.trackpad.enableSecondaryClick" = true;
      AppleICUForce24HourTime = true; # 24 hr clock
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3; # keyboard control over OSX UI; 0 - tab in modal dialogs; 2/3 = all controls
      AppleMetricUnits = 1;
      ApplePressAndHoldEnabled = false; # diasable in favour of key-repeat
      AppleShowScrollBars = "WhenScrolling";

      InitialKeyRepeat = 20; # Set fast key repeat
      KeyRepeat = 1; # Set fast key repeat

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false; # PITA with coding
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false; # PITA with coding
      NSAutomaticSpellingCorrectionEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;

      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSTableViewDefaultSizeMode = 2; # finder sidebar icon size: 1,2,3

      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
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
}
