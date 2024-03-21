{
  upkgs,
  pkgs,
  config,
  ...
}: let
  # TODO: Better way to get flake location?
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
  home.packages = [
    upkgs.neovim
    upkgs.pngpaste # obsidian.nvim
    pkgs.alejandra # nix formatter. Not available on Mason yet..
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
}
