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
  home.packages = [
    upkgs.pywal
  ];

  home.file."${config.xdg.configHome}/wal/templates/colors-rofi-pywal.rasi".text = ''
      * {{
        background: rgba(0,0,1,0.5);
        foreground: #FFFFFF;
        color0:     {color0};
        color1:     {color1};
        color2:     {color2};
        color3:     {color3};
        color4:     {color4};
        color5:     {color5};
        color6:     {color6};
        color7:     {color7};
        color8:     {color8};
        color9:     {color9};
        color10:    {color10};
        color11:    {color11};
        color12:    {color12};
        color13:    {color13};
        color14:    {color14};
        color15:    {color15};
    }}
  '';

  home.activation = let
    wallpaper = builtins.toPath ../../../../wallpapers/b-314.jpg;
  in {
    setWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${inputs.nixpkgs-wayland.packages.${system}.swww}/bin/swww img ${wallpaper}
    '';
    createThemeColorsFromWallpaer = lib.hm.dag.entryAfter ["setWallpaper"] ''
      run ${upkgs.pywal}/bin/wal -i ${wallpaper}
    '';
  };
}