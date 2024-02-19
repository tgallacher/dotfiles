{
  self,
  pkgs,
  upkgs,
  config,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      # Neovim/Mason dep.

      nodejs_20 # Also req. for Neovim/Mason
      cargo # (rnix)
      terraform # (terraform-fmt)
      coreutils # (C utils)
      gcc # (C compiler)
      gnumake
      pyenv
      alejandra # Nix formatter
      # stylua # Nix formatter

      # CLI

      ripgrep
      btop # Resource manager
      bat # cat with wings
      curl # Fetch stuff
      difftastic # Diff visualiser
      direnv # Dynamic shell configs
      dwdiff # Another diff visualiser
      fzf # Find stuff (also dep. of Neovim/Telescope)
      git # Version control
      glib # require GIO for NvimTree
      iperf # Network performance
      ranger # File manager
      w3m # img preview in ranger
      tldr # Man docs helper

      # File Management

      rsync # File transfer
      unzip # Zip files
      unrar # Rar files
      zip # Zip
      ;

    inherit
      (upkgs)
      # CLIs

      python3
      ;
  };
}
