# base.nix
#   Set a common baseline for each non-server computer
{
  lib,
  pkgs,
  upkgs,
  inputs,
  vars,
  config,
  host,
  ...
}: {
  imports = [
    ../libs/nix.nix
  ];

  networking.hostName = host.name;
  time.timeZone = "Europe/London";

  # List packages installed in system profile.
  # To search, run: `$ nix search <pacakge_name>`
  environment.systemPackages = [];

  users.users.${vars.username} = {
    shell = upkgs.zsh;
  };
}
