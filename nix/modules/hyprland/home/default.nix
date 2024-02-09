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
    ./hyprland.nix
    ./pywal.nix
    ./rofi
    ./swaylock.nix
    ./waybar
    ./wlogout
  ];
}
