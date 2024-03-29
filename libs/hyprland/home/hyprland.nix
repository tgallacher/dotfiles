# Note: This is a Home Manager module
{
  self,
  lib,
  upkgs,
  pkgs,
  inputs,
  system,
  config,
  ...
}: let
  wallpaper = builtins.toPath ../../../../wallpapers/b-314.jpg;
in {
  home.packages = [
    upkgs.bluez # bluetooth
    upkgs.bluez-tools # bluetooth
    upkgs.blueman # bluetooth

    # upkgs.wl-clipboard # Wayland equiv of pbcopy; Neovim also requires this for `unnamedplus` register
    upkgs.cliphist
    upkgs.go # req. by cliphist
    upkgs.xdg-utils # req. by cliphist

    upkgs.jq # use for rofi window switching
    upkgs.qalculate-gtk # calculator app
    upkgs.networkmanagerapplet # used in waybar
    # upkgs.libnotify # provides `notify-send`

    inputs.nixpkgs-wayland.packages.${system}.grim
    inputs.nixpkgs-wayland.packages.${system}.slurp
    inputs.nixpkgs-wayland.packages.${system}.swww
    inputs.nixpkgs-wayland.packages.${system}.wl-clipboard # Wayland equiv of pbcopy; Neovim also requires this for `unnamedplus` register
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = upkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = upkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = upkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  # See fixme below in `home.activation`
  # xdg.configFile."hypr/hyprpaper.conf".text = ''
  #   preload = ${wallpaper}
  #   wallpaper = ,${wallpaper}
  # '';

  home.activation = {
    createThemeColorsFromWallpaer = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${upkgs.pywal}/bin/wal -i ${wallpaper}

      # FIXME: HYPRLAND_INSTANCE_SIGNATURE not set! (is hyprland running?)
      # note: HM activation scripts seem to run before greetd service (which triggers hyprland, etc) so all daemons won't have booted yet. Need to work around this
      # run ${inputs.hyprland.packages.${system}.hyprland}/bin/hyprctl hyprpaper wallpaper ${wallpaper}
      # run (${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww query || ${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww init) && ${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww img ${wallpaper}
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["-all"];
    };
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";

      monitor = ",preferred,auto,1";

      general = {
        layout = "master";
        border_size = 1;
        gaps_in = 5;
        gaps_out = 10;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      master = {
        new_is_master = false;
      };

      dwindle = {
        force_split = 2;
        preserve_split = false;
      };

      decoration = {
        rounding = 2;
        dim_inactive = true;
      };

      input = {
        kb_layout = "gb";
      };

      exec-once = [
        "${upkgs.pywal}/bin/wal -R"
        "${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww query || ${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww init"
        "${inputs.nixpkgs-wayland.packages.${system}.waybar}/bin/waybar"
        "${inputs.nixpkgs-wayland.packages.${system}.wl-clipboard}/bin/wl-paste --watch cliphist store" # send clipboard entires to cliphist
        # # "blueman-applet"
        # # "nm-applet --indicator"
      ];

      bind = [
        "$mod       , W           , exec                      , wlogout"
        "$mod SHIFT , W           , exec                      , pkill waybar && waybar &"
        "$mod SHIFT , SPACE       , exec                      , pkill rofi || rofi -show drun"
        "$mod       , SPACE       , exec                      , pkill rofi || hyprctl clients -j | jq -r 'map(select( .class != \"\" )) | sort_by( .focusHistoryID )| .[] | (.address + \"\t\" + .title)' | rofi -dmenu -display-columns 2 | awk '{print $1;}' | xargs -I{} hyprctl dispatcher focuswindow \"address:{}\""
        "$mod       , B           , exec                      , brave"
        "$mod       , RETURN      , exec                      , $terminal"
        # "           , Print       , exec                      , grimblast copy area"
        # compositor commands
        "$mod SHIFT , E           , exec                      , pkill Hyprland"
        "$mod       , Q           , killactive                ,"
        "$mod       , F           , fullscreen                ,"
        "$mod       , G           , togglegroup               ,"
        "$mod SHIFT , N           , changegroupactive         , f"
        "$mod SHIFT , P           , changegroupactive         , b"
        "$mod       , R           , togglesplit               ,"
        "$mod       , T           , togglefloating            ,"
        "$mod       , P           , pseudo                    ,"
        "$mod ALT   ,             , resizeactive              ,"
        # Move window focus
        "$mod       , H           , movefocus                 , l"
        "$mod       , K           , movefocus                 , u"
        "$mod       , L           , movefocus                 , r"
        "$mod       , J           , movefocus                 , d"
        # Move window position
        "$mod CTRL  , H           , movewindow                , l"
        "$mod CTRL  , K           , movewindow                , u"
        "$mod CTRL  , L           , movewindow                , r"
        "$mod CTRL  , J           , movewindow                , d"
        # Move active window to workspace [1-6] (don't follow)
        "$mod CTRL  , 1           , movetoworkspacesilent     , 1"
        "$mod CTRL  , 2           , movetoworkspacesilent     , 2"
        "$mod CTRL  , 3           , movetoworkspacesilent     , 3"
        "$mod CTRL  , 4           , movetoworkspacesilent     , 4"
        "$mod CTRL  , 5           , movetoworkspacesilent     , 5"
        "$mod CTRL  , 6           , movetoworkspacesilent     , 6"
        "$mod CTRL  , braketleft  , movetoworkspacesilent     , -1"
        "$mod CTRL  , braketright , movetoworkspacesilent     , +1"
        # Move active window to workspace [1-6] (and follow)
        "$mod ALT   , 1           , movetoworkspace           , 1"
        "$mod ALT   , 2           , movetoworkspace           , 2"
        "$mod ALT   , 3           , movetoworkspace           , 3"
        "$mod ALT   , 4           , movetoworkspace           , 4"
        "$mod ALT   , 5           , movetoworkspace           , 5"
        "$mod ALT   , 6           , movetoworkspace           , 6"
        "$mod ALT   , braketleft  , movetoworkspace           , -1"
        "$mod ALT   , braketright , movetoworkspace           , +1"
        # Switch to workspace [1-6]
        "$mod       , 1           , workspace                 , 1"
        "$mod       , 2           , workspace                 , 2"
        "$mod       , 3           , workspace                 , 3"
        "$mod       , 4           , workspace                 , 4"
        "$mod       , 5           , workspace                 , 5"
        "$mod       , 6           , workspace                 , 6"
        "$mod SHIFT , H           , workspace                 , -1"
        "$mod SHIFT , L           , workspace                 , +1"

        # TODO: Media Controls
      ];

      windowrule = [];

      windowrulev2 = [
        # Apps::
        # File manager
        "animation popin,class:^(thunar)$"
        "opacity 0.8 0.8,class:^(thunar)$"
        # Qalculate
        "float,class:^(qalculate-gtk)$"
        "center,class:^(qalculate-gtk)$"
        # Dunst
        "opacity 0.8 0.8,class:^(Dunst)$"

        # Workspaces::
        # Workspace: Notes
        "workspace 2,class:^(obsidian)$"
        "workspace 2,class:^(1Password)$"
        "workspace 2,class:^(thunderbird)$"
        # Workspace: Personal Media
        "workspace 3,class:^(Spotify)$"
        "workspace 3,class:^(whatsapp-for-linux)$"
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
