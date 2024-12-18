{
  upkgs,
  pkgs,
  host,
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

  xdg.dataFile."nvim/get_openai_api_key.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      ${
        if host.name == "m1pro"
        then "op item get OpenAI --fields apikey --vault Personal --cache"
        else if host.name == "supapro"
        then ''
          # FIXME: remove nodejs deprection supression
          export BW_SESSION=$(NODE_OPTIONS="--no-deprecation" bw unlock --passwordfile ~/.bwclipwd --raw)
          NODE_OPTIONS="--no-deprecation" bw get item 03b6d062-448e-4135-97ac-b24100965193 | jq -r '.fields[] | select(.name == "apikey") | .value'
        ''
        else ""
      }

    '';
  };

  programs.zsh = {
    enable = true;
    package = upkgs.zsh;
    autosuggestion.enable = false; # we'll handle this in antidote
    enableCompletion = false; # we'll handle this in antidote
    defaultKeymap = "viins"; # Vim INSERT mode; hit ESC to toggle between VI INSERT/VISUAL
    dotDir = ".config/zsh";
    autocd = true;
    ## add to .zlogout
    logoutExtra = ''
      ## Ensure keychain is logged at logout
      if [ command -v aws-vault >/dev/null 2>&1 ]; then
        security lock-keychain aws-vault.keychain.db
      fi
    '';
    ## add to .zshenv
    envExtra = ''
      export LC_ALL=en_GB.UTF-8

      ${ # FIXME: magic string
        if (host.name == "flawpro") || (host.name == "supapro")
        then "alias assume=\"source assume\""
        else ""
      }
    '';
    ## add to .zshrc
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

      ## NVM config
      mkdir -p "$HOME/.nvm" # ensure nvm dir exists
      export NVM_DIR="$HOME/.nvm"
      [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

      # Fix for brew's `libiconv` formulae, and it not wanting to override OSX's default
      # see: https://stackoverflow.com/a/71895124
      export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix libiconv)/lib

      # load custom config, avoiding the need to commit into git (e.g. secrets, etc)
      if [ -f $HOME/.custom.zshrc ]; then
          source $HOME/.custom.zshrc
      fi
    '';
    ## add to .zshrc, top of file
    initExtraFirst = ''
      # TODO: This needs to come before `antidote load` to avoid "compdef not found" error
      autoload -Uz compinit && compinit

      # Docker*
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes

      # see: https://github.com/ohmyzsh/ohmyzsh/issues/11817#issuecomment-1655430206
      zstyle ':omz:plugins:docker' legacy-completion yes

      # FIXME: Move this into "flawpro" config
      export GRANTED_ALIAS_CONFIGURED=true;
      export GRANTED_DISABLE_UPDATE_CHECK=true;

      export CASE_SENSITIVE="true";
      export HIST_STAMPS="yyyy-mm-dd";
      export BROWSER="brave";
      export XDG_CONFIG_HOME="$HOME/.config";

    '';
    ## add to .zprofile
    profileExtra = ''
      ${
        if pkgs.stdenv.isDarwin
        then "eval \"$(/opt/homebrew/bin/brew shellenv)\""
        else ""
      }
    '';
    ## add to .zshrc, top of file, env vars, e.g. POWERLINE_9K, etc
    localVariables = {
      # CASE_SENSITIVE = "true";
      # HIST_STAMPS = "yyyy-mm-dd";
      # BROWSER = "brave";
      # XDG_CONFIG_HOME = "$HOME/.config";
    };
    dirHashes = {};
    ## env vars set for each session
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
      ecr-login = "aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin $(aws sts get-caller-identity | jq -r '.Account').dkr.ecr.eu-west-1.amazonaws.com";
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
