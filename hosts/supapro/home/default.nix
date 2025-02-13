{
  upkgs,
  pkgs,
  inputs,
  vars,
  lib,
  ...
}: {
  imports = [
    # inputs.mac-app-util.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
    ../../../home/base.nix
    ../../../home/terminal
    ../../../home/nvim
    # (
    #   {self, ...}: {
    #     nixpkgs.overlays = [
    #       (final: prev: {
    #         git = final.git.override {
    #           userEmail = "173261044+tomg-flwls@users.noreply.github.com";
    #         };
    #       })
    #     ];
    #   }
    # )
    # {
    #   programs.git.userEmail = lib.mkForce "173261044+tomg-flwls@users.noreply.github.com";
    # }
  ];

  colorScheme = inputs.nix-colors.colorSchemes.porple;

  home = {
    username = vars.username;
    homeDirectory = lib.mkForce "/Users/${vars.username}";
    stateVersion = "24.11";
  };

  home.packages = [
    # upkgs.raycast # NOTE: updates are behind Brew, and some extension require latest version
    upkgs.pwgen
    # FIXME: require >0.30 to fix terminal killer bug
    # Use brew for now...
    # upkgs.granted # simplified cloud account switching
    upkgs.awscli2
    upkgs.ssm-session-manager-plugin
    # pkgs.mkcert # self-signed tls certs
    upkgs.jqp # TUI for navigating jq

    # Python
    # upkgs.uv # pip replacement + more
    # pkgs.poetry # pip replacement
    # pkgs.poethepoet # task runner for poetry
  ];

  home.file.".hushlogin".text = ''# silence tty start up spam '';

  xdg.dataFile.".get_otp.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      pkill -f "single $1"
      osascript -e 'tell app "System Events" to display alert "AWS CLI" message "Touch your YubiKey" as critical' >/dev/null 2>&1 &
      otp=$(ykman oath accounts code --single "$1")
      osascript -e 'tell app "System Events" to tell process "System Events" to click button "OK" of window 1' >/dev/null 2>&1
      echo "''${otp}"
    '';
  };

  # Let Home Manager manage itself (standalone use)
  programs.home-manager.enable = true;
}
