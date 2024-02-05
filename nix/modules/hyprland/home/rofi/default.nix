{
  self,
  inputs,
  system,
  config,
  vars,
  upkgs,
  pkgs,
  ...
}: {
  imports = [
    ./theme.nix
  ];

  programs.rofi = {
    enable = true;
    package = upkgs.rofi;
    location = "center";
    cycle = true;
    font = "Fira Sans Bold 12";
    # FIXME: Pull from `config`
    # terminal = config.users.users.${vars.username}.shell;
    terminal = "${upkgs.zsh}/bin/zsh";
    extraConfig = {
      modi = "drun,run";
      show-icons = false;
      icon-theme = "kora";
      display-drun = "APPS";
      display-run = "RUN";
      display-filebrowser = "FILES";
      display-window = "WINDOW";
      drun-display-format = "{name}";
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      window-format = "{w} · {c} · {t}";
    };
  };
}
