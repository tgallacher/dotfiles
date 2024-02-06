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
  imports = [
    ./style.nix
    ./modules.nix
  ];

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
          "custom/appmenu"
          "wlr/taskbar"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "bluetooth"
          "tray"
          "idle_inhibitor"
          "custom/exit"
          "network"
          "clock"
        ];
      };
    };
  };
}
