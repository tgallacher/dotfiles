# Note: This is a Home Manager module
{
  self,
  upkgs,
  pkgs,
  inputs,
  system,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.waybar;
    settings = {
      mainBar = {
        ## General
        layer = "top"; # display bar ontop of all windows
        position = "top";
        margin-top = 5;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;
        modules-left = [
          # "hyprland/window"
          "wlr/taskbar"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "bluetooth"
          "network"
          "tray"
          "clock"
          "idle_inhibitor"
          "custom/exit"
        ];

        ## Modules
        # Workspaces
        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          # format = "{}";
          format = "";
          sort-by-numbers = true;
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 3;
          };
        };
        # Taskbar
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          # ignore-list = ["Alacritty"];
          app_ids-mapping = {};
          rewrite = {
            # "Firefox Web Browser" = "Firefox";
            "Foot Server" = "Terminal";
          };
        };
        # Hyprland Window
        "hyprland/window" = {
          separate-outputs = true;
          rewrite = {
            "(.*) - Brave" = "$1";
            "(.*) - Chromium" = "$1";
            "(.*) - Brave Search" = "$1";
            "(.*) - Outlook" = "$1";
            "(.*) Microsoft Teams" = "$1";
          };
        };
        # Power Menu
        "custom/exit" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };
        # System tray
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        # Clock
        clock = {
          timezone = "Europe/London";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
          max-length = 25;
        };
        ## Network
        network = {
          format = "{ifname}";
          format-wifi = "   {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "Disconnected";
          tooltip-format = " {ifname} via {gwaddri}";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          # tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          tooltip-format-ethernet = "{ifname}\t{ipaddr}/{cidr}\ngateway\t{gwaddr}\n\t{essid}\n{icon}  ⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          # on-click= "~/dotfiles/.settings/networkmanager.sh";
        };
        ## Pulseaudio
        pulseaudio = {
          ## "scroll-step"= 1; // %, can be a float
          format = "{icon}  {volume}%";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" " " " "];
          };
          on-click = "pavucontrol";
        };
        ## Bluetooth
        bluetooth = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 60;
          on-click = "blueman-manager";
        };
        ## Idle Inhibator
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          on-click-right = "swaylock";
          tooltip = true;
        };
        cpu = {
          interval = 10;
          format = " {usage: >2}%";
          max-length = 10;
        };
        memory = {
          interval = 30;
          format = " {percentage: >2}%";
          max-length = 10;
        };
      };
    };
    style = ''
      /* Import pywal colors */
      @import "${config.xdg.cacheHome}/wal/colors-waybar.css";

      @define-color bg #fff;
      @define-color bgAlt @color8;
      @define-color accent @color5;
      @define-color textColor @color8;

      /* TODO: Swap these to our names (from ML4W) */
      @define-color backgroundlight @color8;
      @define-color backgrounddark #FFFFFF;
      @define-color workspacesbackground1 @color8;
      @define-color workspacesbackground2 #FFFFFF;
      @define-color bordercolor @color8;
      @define-color textcolor1 @color8;
      @define-color textcolor2 #FFFFFF;
      @define-color textcolor3 #FFFFFF;
      @define-color iconcolor @color8;

      * {
          font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          border: none;
          border-radius: 0px;
      }

      window#waybar {
        background-color: rgba(0,0,0,0.8);
        border-bottom: 0px solid #fff;
        background: transparent;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      /* -----------------------------------------------------
       * Workspaces
       * ----------------------------------------------------- */

      #workspaces {
          background: @bg;
          margin: 2px 1px 3px 1px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-weight: bold;
          font-style: normal;
          opacity: 0.8;
          font-size: 14px;
          color: @textColor;
      }

      #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 15px;
          border: 0px;
          color: @textColor;
          background-color: @bgAlt;
          transition: all 0.3s ease-in-out;
          opacity: 0.4;
      }

      #workspaces button.active {
          color: @textColor;
          background-color: @accent;
          border-radius: 15px;
          min-width: 40px;
          transition: all 0.3s ease-in-out;
          opacity: 1.0;
      }

      #workspaces button:hover {
          color: @textColor;
          background-color: @accent;
          border-radius: 15px;
          opacity: 0.7;
      }

      /* -----------------------------------------------------
       * Taskbar
       * ----------------------------------------------------- */

      #taskbar {
          background: @bg;
          margin: 3px 15px 3px 0px;
          padding: 0px;
          border-radius: 15px;
          font-weight: normal;
          font-style: normal;
          opacity:0.8;
          border: 3px solid @bglight;
      }

      #taskbar button {
          margin:0;
          border-radius: 15px;
          padding: 0px 5px 0px 5px;
      }

      /* -----------------------------------------------------
       * Tooltips
       * ----------------------------------------------------- */

      tooltip {
          border-radius: 10px;
          background-color: @background;
          opacity: 0.8;
          padding: 20px;
          margin: 0px;
      }

      tooltip label {
          color: @textcolor2;
      }

      /* -----------------------------------------------------
       * Window
       * ----------------------------------------------------- */

      #window {
          background: @bglight;
          margin: 5px 15px 5px 0px;
          padding: 2px 10px 0px 10px;
          border-radius: 12px;
          color:@textcolor2;
          font-size:14px;
          font-weight:normal;
          opacity:0.8;
      }

      window#waybar.empty #window {
          background-color:transparent;
      }

      /* -----------------------------------------------------
       * Modules
       * ----------------------------------------------------- */

      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      /* -----------------------------------------------------
       * Custom Quicklinks
       * ----------------------------------------------------- */

      #custom-brave,
      #custom-browser,
      #custom-keybindings,
      #custom-outlook,
      #custom-filemanager,
      #custom-teams,
      #custom-chatgpt,
      #custom-calculator,
      #custom-windowsvm,
      #custom-cliphist,
      #custom-wallpaper,
      #custom-settings,
      #custom-wallpaper,
      #custom-system,
      #custom-waybarthemes {
          margin-right: 23px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }

      #custom-system {
          margin-right:15px;
      }

      #custom-wallpaper {
          margin-right:25px;
      }

      /* -----------------------------------------------------
       * Idle Inhibator
       * ----------------------------------------------------- */

      #idle_inhibitor {
          margin-right: 15px;
          font-size: 22px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }

      #idle_inhibitor.activated {
          margin-right: 15px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: #dc2f2f;
      }

      /* -----------------------------------------------------
       * Custom Modules
       * ----------------------------------------------------- */

      #custom-appmenu, #custom-appmenuwlr {
          background-color: @bgdark;
          font-size: 16px;
          color: @textcolor1;
          border-radius: 15px;
          padding: 0px 10px 0px 10px;
          margin: 3px 15px 3px 14px;
          opacity:0.8;
          border:3px solid @bordercolor;
      }

      /* -----------------------------------------------------
       * Custom Exit
       * ----------------------------------------------------- */

      #custom-exit {
          margin: 0px 20px 0px 0px;
          padding: 0px;
          font-size: 20px;
          color: @iconcolor;
      }

      /* -----------------------------------------------------
       * Hardware Group
       * ----------------------------------------------------- */

      #disk,#memory,#cpu,#bluetooth {
          margin: 0 5px;
          padding: 2px 10px 0px 10px;
          font-size: 14px;
          background-color: @bg;
          border-radius: 15px;
          color: @textColor;
          opacity: 0.8;
      }

      /* -----------------------------------------------------
       * Clock
       * ----------------------------------------------------- */

      #clock {
          background-color: @bg;
          font-size: 14px;
          color: @textColor;
          border-radius: 15px;
          padding: 0px 10px;
          margin: 0 5px;
          opacity: 0.8;
          border:3px solid @accent;
      }

      /* -----------------------------------------------------
       * Pulseaudio
       * ----------------------------------------------------- */

      #pulseaudio {
          background-color: @bg;
          font-size: 14px;
          color: @textColor;
          border-radius: 15px;
          padding: 0px 10px;
          margin: 0 5px;
          opacity: 0.8;
      }

      #pulseaudio.muted {
          background-color: red;
          color: @textColor;
      }

      /* -----------------------------------------------------
       * Network
       * ----------------------------------------------------- */

      #network {
          background-color: @bg;
          font-size: 12px;
          color: @textColor;
          border-radius: 15px;
          padding: 0px 10px;
          margin: 0 5px;
          opacity: 0.8;
      }

      /* -----------------------------------------------------
       * Tray
       * ----------------------------------------------------- */

      #tray {
          padding: 0px 15px 0px 0px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }



    '';
  };
}
