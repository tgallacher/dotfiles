{
  pkgs,
  upkgs,
  ...
}: {
  # useful tool; required for telescope
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

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
      fd # nvim telescope uses this
      btop # Resource manager
      bat # cat with wings
      curl # Fetch stuff
      difftastic # Diff visualiser
      direnv # Dynamic shell configs
      dwdiff # Another diff visualiser

      git # Version control
      glib # require GIO for NvimTree
      iperf # Network performance
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
