{
  upkgs,
  config,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = upkgs.wezterm;
    extraConfig = ''
      -- load external config file so we can get syntax highlighting
      local config = require("config")

      return config
    '';
  };

  home.file.".config/wezterm/config.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/tgallacher/dotfiles/home/terminal/wezterm/config.lua";
}
