{
  self,
  upkgs,
  config,
  vars,
  ...
}: let
  hasSketchybar = config.services.sketchybar.enable;
in {
  services.yabai = {
    enable = true;
    package = upkgs.yabai;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      top_padding = 10;
      right_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      window_gap = 10;
      mouse_follows_focus = "off";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      ### OSX
      yabai -m rule --add label="Finder" app="^Finder$" manage=off
      yabai -m rule --add title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add app="^(Calculator|Software Update|Dictionary|System Preferences|System Settings|Photo Booth|Archive Utility|App Store|Alfred|Activity Monitor)$" manage=off

      ### General
      yabai -m rule --add app="^zoom*" manage=off

      ### Space 1: Primary
      # yabai -m rule --add app="^Alacritty" space=^1

      ### Space 2: Secondary
      yabai -m rule --add app="^1Password" space=^2 manage=off
      yabai -m rule --add app="^Bitwarden" space=^2 manage=off
      yabai -m rule --add app="^DBeaver" space=^2
      yabai -m rule --add app="^Postman" space=^2

      ### Space 3: Notes
      yabai -m rule --add app="^Obsidian" space=^3
      yabai -m rule --add app="^TickTick" space=3

      ### Space 4: Social
      yabai -m rule --add app="WhatsApp" space=^4
      yabai -m rule --add app="^Discord" space=^4
      yabai -m rule --add app="^Messages" space=^4
      yabai -m rule --add app="^Slack" space=^4

      ### Space 5: Music
      yabai -m rule --add app="^Spotify" space=^5

      ${
        if hasSketchybar
        then ''
          ### Sketchybar
          yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
          yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
          yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

          yabai -m config external_bar all:32:0
        ''
        else ""
      }

      # run JankyBoarders
      $(${config.homebrew.brewPrefix}/brew --prefix borders)/bin/borders \
        active_color=0xff${config.home-manager.users.${vars.username}.colorScheme.palette.base09} \
        inactive_color=0x00ffffff \
        width=5.0 &
    '';
  };

  services.skhd = {
    enable = true;
    package = upkgs.skhd;
    skhdConfig = ''
      ##
      ## Focus
      ##################################################

      # focus within space
      cmd + ctrl - j : yabai -m window --focus south
      cmd + ctrl - k : yabai -m window --focus north
      cmd + ctrl - h : yabai -m window --focus west
      cmd + ctrl - l : yabai -m window --focus east

      # change focus between external displays (left, right)
      cmd + ctrl - s : yabai -m display --focus west
      cmd + ctrl - g : yabai -m display --focus east

      ##
      ## Windows / Layouts
      ##################################################

      cmd + ctrl          - r : yabai -m space --rotate 270                         # rotate layout clockwise
      cmd + ctrl          - y : yabai -m space --mirror y-axis                      # flip along y-axis
      cmd + ctrl          - x : yabai -m space --mirror x-axis                      # flip along x-axis
      cmd + ctrl          - e : yabai -m space --balance                            # rebalance windows on screen
      cmd + ctrl          - m : yabai -m window --toggle zoom-fullscreen            # toggle fullscreen
      cmd + ctrl          - t : yabai -m window --toggle float --grid 4:4:1:1:2:2 ${ # toggle window float
        if hasSketchybar
        then "; sketchybar --trigger window_focus"
        else ""
      }

      # swap windows
      cmd + alt          - j : yabai -m window --swap south
      cmd + alt          - k : yabai -m window --swap north
      cmd + alt          - h : yabai -m window --swap west
      cmd + alt          - l : yabai -m window --swap east

      # move window and split
      cmd + alt + shift  - j : yabai -m window --warp south
      cmd + alt + shift  - k : yabai -m window --warp north
      cmd + alt + shift  - h : yabai -m window --warp west
      cmd + alt + shift  - l : yabai -m window --warp east

      # move window to separate display
      cmd + shift        - s : yabai -m window --display west; yabai -m display --focus west;
      cmd + shift        - g : yabai -m window --display east; yabai -m display --focus east;
      cmd + shift        - d : yabai -m window --display north; yabai -m display --focus north;
      cmd + shift        - f : yabai -m window --display south; yabai -m display --focus south;

      # move window to prev / next space
      cmd + shift        - p : yabai -m window --space prev
      cmd + shift        - n : yabai -m window --space next

      # move window to space #
      cmd + ctrl         - 1 : yabai -m window --space 1
      cmd + ctrl         - 2 : yabai -m window --space 2
      cmd + ctrl         - 3 : yabai -m window --space 3
      cmd + ctrl         - 4 : yabai -m window --space 4
      cmd + ctrl         - 5 : yabai -m window --space 5
      cmd + ctrl         - 6 : yabai -m window --space 6

      # Resize window
      alt + ctrl         - j : yabai -m window --resize top:0:-150
      alt + ctrl         - k : yabai -m window --resize top:0:150
      alt + ctrl + shift - j : yabai -m window --resize bottom:0:150
      alt + ctrl + shift - k : yabai -m window --resize bottom:0:-150
      alt + ctrl         - h : yabai -m window --resize right:-150:0
      alt + ctrl         - l : yabai -m window --resize right:150:0
      alt + ctrl + shift - h : yabai -m window --resize left:150:0
      alt + ctrl + shift - l : yabai -m window --resize left:-150:0


      ##
      ## Key remaps
      ##################################################

      # survive Apple's 65% keyboard
      fn                 - h : ${upkgs.skhd}/bin/skhd -k "left"
      fn                 - j : ${upkgs.skhd}/bin/skhd -k "down"
      fn                 - k : ${upkgs.skhd}/bin/skhd -k "up"
      fn                 - l : ${upkgs.skhd}/bin/skhd -k "right"

      ##
      ## Services
      ##################################################

      cmd + alt - q : yabai --stop-service
      cmd + alt - s : yabai --start-service
      cmd + alt - r : yabai --restart-service

      cmd + alt + shift - q : ${upkgs.skhd}/bin/skhd --stop-service
      cmd + alt + shift - s : ${upkgs.skhd}/bin/skhd --start-service
      cmd + alt + shift - r : ${upkgs.skhd}/bin/skhd --restart-service
    '';
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.spaces".spans-displays = 0; # 0 means enabled
    "com.apple.dock".mru-spaces = 0;
    "com.apple.WindowManager".StandardHideDesktopIcons = 0;
    "com.apple.WindowManager".EnableStandardClickToShowDesktop = 0;
  };
}
