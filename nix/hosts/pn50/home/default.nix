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
    ./git.nix
    ./terminal
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.packages = [
    pkgs.whatsapp-for-linux
  ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        end_of_line = "lf";
        indent_size = 2;
        charset = "utf-8";
      };
    };
  };

  # Manage Dotfiles
  home.file = {
    # TODO: Better way to get flake location?
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/Code/${vars.username}/dotfiles/nvim";
  };

  # Let Home Manager manage itself (in standalone mode)
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
