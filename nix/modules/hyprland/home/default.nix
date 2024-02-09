{
  self,
  lib,
  inputs,
  vars,
  system,
  upkgs,
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./hyprland.nix
    ./pywal.nix
    ./rofi
    ./swaylock.nix
    ./waybar
    ./wlogout
  ];
}
