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

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "23.05";
  };

  home.packages = [
    pkgs.whatsapp-for-linux
  ];

  # Let Home Manager manage itself (in standalone mode)
  programs.home-manager.enable = true;
}
