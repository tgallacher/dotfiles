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

  xdg.configFile = {
    "mypy/config" = {
      text = ''
        [mypy]
        mypy_path = "~/.local/share/nvim/lazy/python-type-stubs"
      '';
    };
  };

  home.file.".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink nvimConfigLocation;
}
