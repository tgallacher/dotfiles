{
  self,
  upkgs,
  ...
}: {
  services.yabai = {
    enable = true;
    package = upkgs.yabai;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      top_padding = 15;
      right_padding = 15;
      bottom_padding = 15;
      left_padding = 15;
      window_gap = 15;
      mouse_follows_focus = "on";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      # OSX
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add app="^(Calculator|Software Update|Dictionary|System Preferences|System Settings|Photo Booth|Archive Utility|App Store|Alfred|Activity Monitor)$" manage=off
      # Apps
      yabai -m rule --add app="^zoom*" manage=off
      yabai -m rule --add app="^1password" manage=off
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

      cmd + ctrl - r : yabai -m space --rotate 270                         # rotate layout clockwise
      cmd + ctrl - y : yabai -m space --mirror y-axis                      # flip along y-axis
      cmd + ctrl - x : yabai -m space --mirror x-axis                      # flip along x-axis
      cmd + ctrl - t : yabai -m window --toggle float --grid 4:4:1:1:2:2   # toggle window float
      cmd + ctrl - m : yabai -m window --toggle zoom-fullscreen            # toggle fullscreen
      cmd + ctrl - e : yabai -m space --balance                            # rebalance windows on screen

      # Resize window
      cmd + ctrl - j : yabai -m window --resize bottom:150:0
      cmd + ctrl - k : yabai -m window --resize top:150:0
      cmd + ctrl - h : yabai -m window --resize left:150:0
      cmd + ctrl - l : yabai -m window --resize right:150:0

      cmd + ctrl + shift - j : yabai -m window --resize bottom:-150:0
      cmd + ctrl + shift - k : yabai -m window --resize top:-150:0
      cmd + ctrl + shift - h : yabai -m window --resize left:-150:0
      cmd + ctrl + shift - l : yabai -m window --resize right:-150:0

      # swap windows
      cmd + alt - j : yabai -m window --swap south
      cmd + alt - k : yabai -m window --swap north
      cmd + alt - h : yabai -m window --swap west
      cmd + alt - l : yabai -m window --swap east

      # move window and split
      cmd + alt + shift - j : yabai -m window --warp south
      cmd + alt + shift - k : yabai -m window --warp north
      cmd + alt + shift - h : yabai -m window --warp west
      cmd + alt + shift - l : yabai -m window --warp east

      # move window to separate display
      cmd + shift - s : yabai -m window --display west; yabai -m display --focus west;
      cmd + shift - g : yabai -m window --display east; yabai -m display --focus east;
      cmd + shift - d : yabai -m window --display north; yabai -m display --focus north;
      cmd + shift - f : yabai -m window --display south; yabai -m display --focus south;

      # move window to prev and next space
      cmd + shift - p : yabai -m window --space prev;
      cmd + shift - n : yabai -m window --space next;

      # move window to space #
      ctrl + shift - 1 : yabai -m window --space 1;
      ctrl + shift - 2 : yabai -m window --space 2;
      ctrl + shift - 3 : yabai -m window --space 3;
      ctrl + shift - 4 : yabai -m window --space 4;
      ctrl + shift - 5 : yabai -m window --space 5;
      ctrl + shift - 6 : yabai -m window --space 6;

      ##
      ## Services
      ##################################################

      cmd + alt - q : yabai --stop-service
      cmd + alt - s : yabai --start-service
      cmd + alt - r : yabai --restart-service

      cmd + alt + shift - q : skhd --stop-service
      cmd + alt + shift - s : skhd --start-service
      cmd + alt + shift - r : skhd --restart-service
    '';
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.spaces".spans-displays = 0; # 0 means enabled
    "com.apple.dock".mru-spaces = 0;
    "com.apple.WindowManager".StandardHideDesktopIcons = 0;
    "com.apple.WindowManager".EnableStandardClickToShowDesktop = 0;
  };
}
