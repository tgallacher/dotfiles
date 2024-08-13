{
  pkgs,
  upkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = upkgs.kitty;
    # font = {
    #   normal = {
    #     family = "JetBrainsMono Nerd Font";
    #     style = "Regular";
    #   };
    # };
  };
}
