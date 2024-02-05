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
    ./wofi.nix
    ./waybar
    ./pywal.nix
  ];
}
