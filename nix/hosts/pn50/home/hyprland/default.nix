{self, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";

      general = {
        layout = "master";
        border_size = 2;
        gaps_in = 5;
        gaps_out = 5;
        cursor_inactive_timeout = 5;
      };

      misc = {
        disable_hyprland_logo = "yes";
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      decoration = {
        rounding = 2;
        dim_inactive = true;
      };

      input = {
        kb_layout = "gb";
      };

      exec-once = [
        "swww init"
        "mako"
        "waybar"
        # "wl-paste --watch cliphist store"
        # "blueman-applet"
        # "nm-applet --indicator"
      ];

      # Triggers on release of keys
      bindr = [];

      bind = [
        "$mod, SPACE, exec, pkill wofi || wofi"
        "$mod, B, exec, brave"
        "$mod, RETURN, exec, $terminal"
        # ", Print, exec, grimblast copy area"
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # Move window focus
        "$mod, H, movefocus, l"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, d"
        # Move window position
        "$mod CTRL, H, movewindow, l"
        "$mod CTRL, K, movewindow, u"
        "$mod CTRL, L, movewindow, r"
        "$mod CTRL, J, movewindow, d"

        # Move active window to workspace [1-6] (don't follow)
        "$mod CTRL, 1, movetoworkspacesilent, 1"
        "$mod CTRL, 2, movetoworkspacesilent, 2"
        "$mod CTRL, 3, movetoworkspacesilent, 3"
        "$mod CTRL, 4, movetoworkspacesilent, 4"
        "$mod CTRL, 5, movetoworkspacesilent, 5"
        "$mod CTRL, 6, movetoworkspacesilent, 6"
        "$mod CTRL, braketleft, movetoworkspacesilent, -1"
        "$mod CTRL, braketright, movetoworkspacesilent, +1"
        # Move active window to workspace [1-6] (and follow)
        "$mod ALT, 1, movetoworkspace, 1"
        "$mod ALT, 2, movetoworkspace, 2"
        "$mod ALT, 3, movetoworkspace, 3"
        "$mod ALT, 4, movetoworkspace, 4"
        "$mod ALT, 5, movetoworkspace, 5"
        "$mod ALT, 6, movetoworkspace, 6"
        "$mod ALT, braketleft, movetoworkspace, -1"
        "$mod ALT, braketright, movetoworkspace, +1"
        # Switch to workspace [1-6]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"

        # TODO: Media Controls
      ];

      windowrulev2 = [
        "animation popin,class:^(dolphin)$"
        "opacity 0.8 0.8,class:^(dolphin)$"
        # Wofi
        "move cursor -3% -105%,class:^(wofi)$"
        "noanim,class:^(wofi)$"
        "opacity 0.8 0.6,class:^(wofi)$"
      ];
    };
  };

  # make stuff work on Wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    NIXOS_OZONE_WL = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}
