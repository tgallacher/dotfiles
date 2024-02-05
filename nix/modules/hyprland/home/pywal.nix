# Note: This is a Home Manager module
{
  self,
  lib,
  upkgs,
  pkgs,
  inputs,
  system,
  ...
}: {
  home.packages = [
    upkgs.pywal
  ];

  home.activation = let
    wallpaper = builtins.toPath ../../../../.config/wallpapers/bg_22.jpg;
  in {
    setWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww img ${wallpaper}
    '';
    createThemeColorsFromWallpaer = lib.hm.dag.entryAfter ["setWallpaper"] ''
      run ${upkgs.pywal}/bin/wal -i ${wallpaper}
    '';
  };
}
