# Note: This is a Home Manager module
{
  self,
  upkgs,
  pkgs,
  inputs,
  system,
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
        margin-top = 14;
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
          format = "{}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };
        # Taskbar
        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = ["Alacritty"];
          app_ids-mapping = {
            "firefoxdeveloperedition" = "firefox-developer-edition";
          };
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
          ## "timezone"= "America/New_York";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        ## Network
        network = {
          format = "{ifname}";
          format-wifi = "   {signalStrength}%";
          format-ethernet = "  {ifname}";
          format-disconnected = "Disconnected";
          tooltip-format = " {ifname} via {gwaddri}";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          # on-click= "~/dotfiles/.settings/networkmanager.sh";
        };
        ## Pulseaudio
        pulseaudio = {
          ## "scroll-step"= 1; // %, can be a float
          format = "{icon} {volume}%";
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
          interval = 30;
          on-click = "blueman-manager";
        };
        ## Other
        user = {
          format = "{user}";
          interval = 60;
          icon = false;
        };
        ## Idle Inhibator
        idle_inhibitor = {
          format = "{icon}";
          tooltip = true;
          format-icons = {
            activated = "";
            deactivated = "";
          };
          on-click-right = "swaylock";
        };
      };
    };
    # style = ''
    # '';
  };
}
