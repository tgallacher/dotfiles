{
  self,
  config,
  pkgs,
  upkgs,
  vars,
  inputs,
  system,
  ...
}: {
  imports = [
    ./git.nix
    ./terminal
  ];

  home.username = vars.username;
  home.homeDirectory = vars.homedir;

  home.packages = [
    pkgs.whatsapp-for-linux

    # wayland
    upkgs.bluez # bluetooth
    upkgs.bluez-tools # bluetooth
    upkgs.blueman # bluetooth
    inputs.nixpkgs-wayland.packages.${system}.grim
    inputs.nixpkgs-wayland.packages.${system}.mako
    inputs.nixpkgs-wayland.packages.${system}.slurp
    inputs.nixpkgs-wayland.packages.${system}.swaylock-effects
    inputs.nixpkgs-wayland.packages.${system}.swww
    inputs.nixpkgs-wayland.packages.${system}.waybar
    inputs.nixpkgs-wayland.packages.${system}.wlogout
    inputs.nixpkgs-wayland.packages.${system}.wofi
  ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        end_of_line = "lf";
        indent_size = 2;
        charset = "utf-8";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

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
      bindr = [
      ];

      bind = [
        "$mod, SPACE, exec, pkill wofi || wofi"
        "$mod, B, exec, brave"
        "$mod, RETURN, exec, alacritty"
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

  programs.wofi = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.wofi;
    settings = {
      allow_images = true;
      allow_markup = true;
      content_halign = "fill";
      dynamic_lines = true;
      filter_rate = 100;
      gtk_dark = true;
      halign = "fill";
      height = "30%";
      image_size = 32;
      insensitive = true;
      location = "center";
      matching = "fuzzy"; # fuzzy | contains | multi-contains
      no_actions = true;
      orientation = "vertical";
      prompt = "Search...";
      show = "drun";
      terminal = "alacritty";
      width = "50%";
    };
    style = ''
      *{
      	font-family: "JetBrainsMono Nerd Font";
      	min-height: 0;
      	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
      	font-size: 98%;
      	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      	padding: 0px;
      	margin-top: 1px;
      	margin-bottom: 1px;
      }

      #window {
        background-color: #323232;
        border-radius: 8px;
      }

      #outer-box {
        padding: 10px;
      }

      #input {
        background-color: #323232;
        /*border: 1px solid #1e1e2e;*/
        padding: 4px 6px;
        color: #585b70;
      }

      #scroll {
        margin-top: 10px;
        margin-bottom: 10px;
      }

      #inner-box {
        border-radius: 8px;
      }

      #img {
        padding-right: 5px;
      }

      #text {
        color: white;
      }

      #text:selected {
        color: black;
      }

      #entry {
        padding: 3px;
      }

      #entry:selected {
        background: linear-gradient(90deg, #89b4fa, #b4befe, #89b4fa);
        border-radius: 8px;
      }

      #unselected { }

      #selected { }

      #input, #entry:selected {
        border-radius: 10px;
        border: 1px solid #b4befe;
      }
    '';
    # style = ''
    #   window {
    #       margin: 0px;
    #       border: 5px solid #1e1e2e;
    #       background-color: #cdd6f4;
    #       border-radius: 0px;
    #   }

    #   #input {
    #       padding: 4px;
    #       margin: 4px;
    #       padding-left: 20px;
    #       border: none;
    #       color: #cdd6f4;
    #       font-weight: bold;
    #       background-color: #1e1e2e;
    #      	outline: none;
    #       border-radius: 15px;
    #       margin: 10px;
    #       margin-bottom: 2px;
    #   }
    #   #input:focus {
    #       border: 0px solid #1e1e2e;
    #       margin-bottom: 0px;
    #   }

    #   #inner-box {
    #       margin: 4px;
    #       border: 10px solid #1e1e2e;
    #       color: #cdd6f4;
    #       font-weight: bold;
    #       background-color: #1e1e2e;
    #       border-radius: 15px;
    #   }

    #   #outer-box {
    #       margin: 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #1e1e2e;
    #   }

    #   #scroll {
    #       margin-top: 5px;
    #       border: none;
    #       border-radius: 15px;
    #       margin-bottom: 5px;
    #       /* background: rgb(255,255,255); */
    #   }

    #   #img:selected {
    #       background-color: #89b4fa;
    #       border-radius: 15px;
    #   }

    #   #text:selected {
    #       color: #cdd6f4;
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #89b4fa;
    #   }

    #   #entry {
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: transparent;
    #   }

    #   #entry:selected {
    #       margin: 0px 0px;
    #       border: none;
    #       border-radius: 15px;
    #       background-color: #89b4fa;
    #   }
    # '';
  };

  # Manage Dotfiles
  home.file = {
    # TODO: Better way to get flake location?
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${vars.homedir}/Code/${vars.username}/dotfiles/nvim";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
