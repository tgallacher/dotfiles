{
  self,
  config,
  ...
}: {
  xdg.configFile."waybar/scripts/cliphist.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      case $1 in
        d) cliphist list | rofi -dmenu -replace | cliphist delete
           ;;

        w) if [ `echo -e "Clear\nCancel" | rofi -dmenu` == "Clear" ] ; then
                cliphist wipe
           fi
           ;;

        *) cliphist list | rofi -dmenu -replace | cliphist decode | wl-copy
           ;;
      esac
    '';
  };

  programs.waybar.settings.mainBar = {
    ## Modules
    # Application Launcher
    "custom/appmenu" = {
      "format" = "Apps";
      "on-click" = "rofi -replace -show drun";
      "tooltip" = false;
    };
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
      };
    };
    "custom/cliphist" = {
      "format" = "";
      "on-click" = "sleep 0.1 && ${config.xdg.configHome}/waybar/scripts/cliphist.sh";
      "on-click-right" = "sleep 0.1 && ${config.xdg.configHome}/waybar/scripts/cliphist.sh d";
      "on-click-middle" = "sleep 0.1 && ${config.xdg.configHome}/waybar/scripts/cliphist.sh w";
      "tooltip" = false;
    };
    # Power Menu
    "custom/exit" = {
      format = "";
      on-click = "wlogout";
      tooltip = false;
    };
    # Filemanager Launcher
    "custom/filemanager" = {
      "format" = "";
      "on-click" = "dolphin";
      "tooltip" = false;
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
      tooltip-format-wifi = ''
          {ifname} @ {essid}
        IP: {ipaddr}
        Strength: {signalStrength}%
        Freq: {frequency}MHz
        Up: {bandwidthUpBits} Down: {bandwidthDownBits}
      '';
      tooltip-format-ethernet = ''
        {ifname}  {ipaddr}/{cidr}
        gateway   {gwaddr}
        {essid}
        {icon}    ⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}
      '';
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
      on-click = "nm-connection-editor";
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
    # ChatGPT Launcher
    "custom/chatgpt" = {
      format = " ";
      on-click = "chromium --app=https=//chat.openai.com";
      tooltip = false;
    };
    # Calculator
    "custom/calculator" = {
      format = "";
      on-click = "qalculate-gtk";
      tooltip = false;
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
    # Hardware
    "group/hardware" = {
      orientation = "inherit";
      modules = [
        "cpu"
        "memory"
      ];
    };
    cpu = {
      interval = 10;
      format = " {usage: >2}%";
      max-length = 10;
    };
    memory = {
      interval = 30;
      format = " {percentage: >2}%";
      max-length = 10;
    };
  };
}
