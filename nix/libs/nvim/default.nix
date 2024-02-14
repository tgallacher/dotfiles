{
  self,
  pkgs,
  config,
  ...
}: let
  nvimConfigLocation = "${config.home.homeDirectory}/Code/${vars.username}/dotfiles/libs/nvim/nvim";
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimAlias = true;
  };

  # TODO: Better way to get flake location?
  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
}
