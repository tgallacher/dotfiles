{
  pkgs,
  upkgs,
  ...
}: {
  programs.direnv.enable = true;

  # versatile cli tool; also required for telescope
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = false; # we'll use sessionizer manually
    # NOTE: Requires `fd` to be installed
    changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"; # <M-c> keybind
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git"; # <C-t> keybind
  };

  programs.yazi = {
    enable = true;
    package = upkgs.yazi;
    enableZshIntegration = true;
    # see: https://yazi-rs.github.io/docs/configuration/yazi
    settings = {
      # flavor.use = "rose-pine";
      manager = {
        sort_dir_first = true;
        sort_by = "modified";
        sort_sensitive = false;
        show_symlink = true;
      };
    };
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

      python310
      # lazygit

      ;
  };

  programs.lazygit = {
    enable = true;
    package = upkgs.lazygit;
    settings = {
      gui = {
        # shortTimeFormat = 3;
        nerdFontsVersion = "3";
        selectedLineBgColor = "default";
        showFileTree = false;
        showRandomTip = true; # TODO: turn off when comfortable
        showBranchCommitHash = true;
        showDivergenceFromBaseBranch = "arrowAndNumber";
        border = "single";
        statusPanelView = "allBranchesLog";
      };
      git = {
        # externalDiffCommand = "";
        parseEmoji = true;
        merging = {
          squashMergeMessage = "chore: squash {{selectedRef}} into {{currentBranch}}";
        };
      };
    };
  };
}
