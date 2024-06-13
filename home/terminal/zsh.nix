{
  upkgs,
  pkgs,
  ...
}: {
  # FIXME: Can't uses this version, need to install this AFTER starship prompt and this doesn't
  # see: github.com/ajeetdsouza/zoxide/issues/74
  programs.zoxide = {
    enable = true;
    package = upkgs.zoxide;
    options = [
      "--cmd cd" # remap to cd and introduce cdi
    ];
  };

  # home.packages = [
  #   upkgs.zoxide
  # ];

  programs.zsh = {
    enable = true;
    package = upkgs.zsh;
    autosuggestion.enable = false; # we'll handle this in antidote
    enableCompletion = false; # we'll handle this in antidote
    defaultKeymap = "viins"; # Vim INSERT mode; hit ESC to toggle between VI INSERT/VISUAL
    dotDir = ".config/zsh";
    autocd = true;
    # add to .zshenv
    envExtra = ''
      export LC_ALL=en_GB.UTF-8
    '';
    # add to .zshrc
    initExtra = ''
      ${
        if pkgs.stdenv.isDarwin
        then "
      print_pid_cwd() {
        local pid=$1;
        lsof -a -p $pid -d cwd -Fn
      }
          "
        else ""
      }
      # Fix for brew's `libiconv` formulae, and it not wanting to override OSX's default
      # see: https://stackoverflow.com/a/71895124
      export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix libiconv)/lib
    '';
    # add to .zshrc, top of file
    initExtraFirst = ''
      # TODO: This needs to come before `antidote load` to avoid "compdef not found" error
      autoload -Uz compinit && compinit

      # Docker*
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes

      # see: https://github.com/ohmyzsh/ohmyzsh/issues/11817#issuecomment-1655430206
      zstyle ':omz:plugins:docker' legacy-completion yes
    '';
    # add to .zprofile
    profileExtra = ''
      ${
        if pkgs.stdenv.isDarwin
        then "eval \"$(/opt/homebrew/bin/brew shellenv)\""
        else ""
      }
    '';
    # add to .zshrc, top of file, env vars, e.g. POWERLINE_9K, etc
    localVariables = {
      CASE_SENSITIVE = "true";
      HIST_STAMPS = "yyyy-mm-dd";
      BROWSER = "brave";
    };
    dirHashes = {};
    # # env vars set for each session
    # sessionVariables = { };
    shellAliases = {
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      sudo = "sudo "; # enable aliases to be sudo'd
      cl = "clear"; # TODO: move to keybind
      v = "nvim";
      sb = "z $HOME/Code/tgallacher/obsidian"; # requires zoxide
      l = "ls -lF ${
        if pkgs.stdenv.isDarwin
        then "-G"
        else "--color"
      }";
      la = "ls -laF ${
        if pkgs.stdenv.isDarwin
        then "-G"
        else "--color"
      }";
      git_prune_branches = "git fetch && git remote prune origin && git br -v | grep gone | awk '{print $1;}' | xargs -n 1 git br -d";
    };
    history.ignoreAllDups = true;
    antidote = {
      enable = true;
      package = upkgs.antidote;
      useFriendlyNames = true;
      plugins = [
        ### Regular plugins
        ### Utilities
        "ohmyzsh/ohmyzsh   path:lib"
        # "ohmyzsh/ohmyzsh   path:copybuffer"
        # "ohmyzsh/ohmyzsh   path:copyfile"
        # "ohmyzsh/ohmyzsh   path:copypath"
        # "ohmyzsh/ohmyzsh   path:extract"
        # "ohmyzsh/ohmyzsh   path:fancy-ctrl-z"
        # "ohmyzsh/ohmyzsh   path:colored-man-pages"
        # "ohmyzsh/ohmyzsh   path:git-extras"
        # "ohmyzsh/ohmyzsh   path:direnv"
        # "ohmyzsh/ohmyzsh   path:node"
        # # completions and/or aliases for various cli tools
        # "ohmyzsh/ohmyzsh   path:plugins/kubectl"
        # "ohmyzsh/ohmyzsh   path:plugins/npm"
        # "ohmyzsh/ohmyzsh   path:plugins/yarn"
        "ohmyzsh/ohmyzsh   path:plugins/git"
        # "ohmyzsh/ohmyzsh   path:plugins/docker"
        # "ohmyzsh/ohmyzsh   path:plugins/terraform"
        # "romkatv/zsh-bench kind:path"
        "djui/alias-tips"
        ### Prompts
        ### Framework: zsh-utils
        "belak/zsh-utils  path:history"
        ### Deferred plugins
        "zdharma-continuum/fast-syntax-highlighting     kind:defer"
        ### completions
        "zsh-users/zsh-completions                      path:src kind:fpath"
        "belak/zsh-utils                                path:completion"
        ### Final Plugins
        "zsh-users/zsh-autosuggestions                  kind:defer"
        "zsh-users/zsh-history-substring-search"
      ];
    };
  };
}
