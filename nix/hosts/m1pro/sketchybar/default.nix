{ self
, upkgs
, pkgs
, config
, vars
, inputs
, lib
, ...
}:
let
  icon_map_sh = pkgs.fetchurl {
    url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v${upkgs.sketchybar-app-font.version}/icon_map.sh";
    hash = "sha256-KWWukG9S0RWp534N115eQaaG9wpVUgcTAqAmrEScHmQ=";
  };
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${vars.username} = import ./home;
      home-manager.extraSpecialArgs = { inherit vars upkgs inputs icon_map_sh; };
    }
  ];

  services.sketchybar = {
    enable = true;
    package = upkgs.sketchybar;
    extraPackages = [
      upkgs.jq # NOTE: Need this one so that the spaces script works..
    ];
  };

  fonts.fonts = [
    upkgs.sketchybar-app-font
  ];

  homebrew = {
    enable = true;
    brews = [
      "ifstat"
      "jq" # FIXME: Why do we need it twice..?
    ];
    casks = [
      # "sf-symbols" # Install SF pro symbols + viewer tool
    ];
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain._HIHideMenuBar = true; # hide OSX menubar
  };
}
