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
    ./rofi
    ./waybar
    ./pywal.nix
  ];
}
