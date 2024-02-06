{
  self,
  config,
  ...
}: {
  programs.waybar.settings.mainBar = {
    ## Modules
    # Application Launcher
    "custom/appmenu" = {
      "format" = "Apps";
      "on-click" = "rofi -show drun -replace";
      "tooltip" = false;
    };
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
}
