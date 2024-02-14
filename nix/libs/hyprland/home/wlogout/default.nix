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
}: {
  programs.wlogout = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.wlogout;
    layout = [
      {
        "label" = "lock";
        "action" = "sleep 1; swaylock";
        "text" = "[L]ock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "[H]ibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "L[o]gout";
        "keybind" = "o";
      }
      {
        "label" = "shutdown";
        "action" = "sleep 1; systemctl poweroff";
        "text" = "[S]hutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "S[u]spend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "[R]eboot";
        "keybind" = "r";
      }
    ];
    style = ''
      @import "${config.xdg.cacheHome}/wal/colors-wlogout.css";

      /* -----------------------------------------------------
       * General
       * ----------------------------------------------------- */

      * {
          font-family: "JetBrainsMono Nerd Font normal", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
      	background-image: none;
      	transition: 20ms;
      }

      window {
      	background-color: rgba(12, 12, 12, 0.1);
      }

      button {
      	color: #FFFFFF;
          font-size:20px;

          background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;

      	border-style: solid;
      	background-color: rgba(12, 12, 12, 0.3);
      	border: 3px solid #FFFFFF;

          box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }

      button:focus,
      button:active,
      button:hover {
          color: @color11;
      	background-color: rgba(12, 12, 12, 0.5);
      	border: 3px solid @color11;
      }

      /*
      -----------------------------------------------------
      Buttons
      -----------------------------------------------------
      */

      #lock {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/lock.png}"));
      }

      #logout {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/logout.png}"));
      }

      #suspend {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/suspend.png}"));
      }

      #hibernate {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/hibernate.png}"));
      }

      #shutdown {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/shutdown.png}"));
      }

      #reboot {
      	margin: 10px;
      	border-radius: 20px;
      	background-image: image(url("${builtins.toPath ./icons/reboot.png}"));
      }
    '';
  };
}
