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
    # ./style.nix
    ./modules.nix
  ];

  programs.waybar = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.waybar;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        ## General
        layer = "top"; # display bar ontop of all windows
        position = "top";
        margin = "0 0 0 0";
        spacing = 0;
        modules-left = [
          # "custom/appmenu"
          "wlr/taskbar"
          "tray"
          "custom/calculator"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "group/hardware"
          "pulseaudio"
          "bluetooth"
          "network"
          "custom/cliphist"
          "custom/filemanager"
          "idle_inhibitor"
          "custom/exit"
          "clock"
        ];
      };
    };
  };
}
