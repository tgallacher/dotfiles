{
  self,
  upkgs,
  config,
  ...
}: let
  nvimConfigLocation = "${config.home.homeDirectory}/Code/tgallacher/dotfiles/home/nvim/nvim";
in {
  imports = [
    ../editorconfig.nix
  ];

  # FIXME: seems borked
  # programs.neovim = {
  #   enable = true;
  #   package = upkgs.neovim;
  #   vimAlias = true;
  # };
  home.packages = [upkgs.neovim];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # TODO: Better way to get flake location?
  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
}
