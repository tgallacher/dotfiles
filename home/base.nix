{
  pkgs,
  upkgs,
  ...
}: {
  programs.direnv.enable = true;

  # versatile cli tool; also required for telescope
  programs.fzf = {
    package = upkgs.fzf;
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = false; # use fzf-tmux? -- we'll use sessionizer manually
    defaultCommand = "${pkgs.fd}/bin/fd --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type=d --hidden --strip-cwd-prefix --exclude .git"; # <M-c> keybind
    fileWidgetCommand = "${pkgs.fd}/bin/fd --hidden --strip-cwd-prefix --exclude .git"; # <C-t> keybind
    # historyWidgetOptions = []; # <C-r> keybind
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
      nodejs_22 # Also req. for Neovim/Mason
      cargo # (rnix)
      terraform # (terraform-fmt)
      coreutils # (C utils)
      gcc # (C compiler)
      gnumake
      pyenv
      alejandra # Nix formatter
      # stylua # Lua formatter
      rustc
      go
      # CLI
      ripgrep
      btop # Resource manager
      bat # cat with wings
      curl # Fetch stuff
      difftastic # Diff visualiser
      tmux
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
      tree
      python310
      fd # nvim telescope uses this
      ;
  };

  programs.lazygit = {
    enable = false;
    package = upkgs.lazygit;
    # FIXME: with $XDG_CONFIG being exported this settings file isn't being put in the right place, i.e. XDG_CONFIG/lazygit
    # This also means that lazy git isn't properly loading any of these changes...
    settings = {
      gui = {
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
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          useConfig = false;
        };
        merging = {
          squashMergeMessage = "chore: squash {{selectedRef}} into {{currentBranch}}";
        };
      };
    };
  };
}
