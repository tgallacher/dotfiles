{
  pkgs,
  upkgs,
  self,
  inputs,
  ...
}: {
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # };

  environment = {
    systemPackages = with upkgs;
      [
        bluez # bluetooth
        bluez-tools # bluetooth
        blueman # bluetooth
      ]
      ++ [
        inputs.nixpkgs-wayland.packages.${system}.grim
        inputs.nixpkgs-wayland.packages.${system}.mako
        inputs.nixpkgs-wayland.packages.${system}.slurp
        inputs.nixpkgs-wayland.packages.${system}.swaylock-effects
        inputs.nixpkgs-wayland.packages.${system}.swww
        inputs.nixpkgs-wayland.packages.${system}.waybar
        inputs.nixpkgs-wayland.packages.${system}.wlogout
        inputs.nixpkgs-wayland.packages.${system}.wofi
      ];
  };
}
