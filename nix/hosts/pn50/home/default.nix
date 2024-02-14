{
  self,
  config,
  pkgs,
  upkgs,
  vars,
  inputs,
  system,
  ...
}: {
  imports = [
    ../../../../home/terminal
    ../../../../home/nvim
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.packages = [
    pkgs.whatsapp-for-linux
  ];

  # Let Home Manager manage itself (in standalone mode)
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
