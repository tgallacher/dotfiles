{
  upkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile."tmux/tmux-sessionizer.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # tmux-sessionizer - https://github.com/ThePrimeagen/.dotfiles

      dirs=(
        ~/Code
      )

      selected_name=""
      tmux_running=$(pgrep tmux)

      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(find ''${dirs[@]} -mindepth 1 -maxdepth 2 -type d | fzf)
      fi

      if [[ -z $selected ]]; then
          exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)

      if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
          tmux new-session -s $selected_name -c $selected
          exit 0
      fi

      if ! tmux has-session -t=$selected_name 2> /dev/null; then
          tmux new-session -ds $selected_name -c $selected
      fi

      tmux switch-client -t $selected_name
    '';
  };

  programs.tmux = let
    theme = {
      trans = "default";
      text = "#${config.colorScheme.palette.base04}";
      primary = "#${config.colorScheme.palette.base09}";
      secondary = "#${config.colorScheme.palette.base0D}";
    };
  in {
    enable = true;
    package = upkgs.tmux;
    baseIndex = 1;
    newSession = false; # spawn session if attach and none exist
    sensibleOnTop = false; # disable due to github.com/nix-community/home-manager/issues/2541
    clock24 = true;
    disableConfirmationPrompt = false;
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -g focus-events on
      set-option -sg escape-time 10

      set-option -ga terminal-overrides ",xterm-256color:Tc"

      set-option -g renumber-windows on             # Re-number remaining windows when one is closed
      unbind -T copy-mode-vi MouseDragEnd1Pane      # don't exit copy mode when dragging with mouse

      ### Keep zoom when moving up/down panes
      bind-key -n M-k select-pane -U \; resize-pane -Z
      bind-key -n M-j select-pane -D \; resize-pane -Z

      ### Easier window split + retain cwd
      unbind '"'
      bind v split-window -v -c "#{pane_current_path}"
      unbind %
      bind h split-window -h -c "#{pane_current_path}"

      ### Easy config reload
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded..."

      ### vim keys to switch windows
      bind -n M-h previous-window
      bind -n M-l next-window

      # Set copy mode to immitate Vim keybindings.
      # Here we adjust the key bind to the copy-mode-vi table in tmux, eg. does not require prefix
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      ### QUICK Switcher
      # Open dir in new Tmux session
      bind-key -r f run-shell "tmux new-window ~/.config/tmux/tmux-sessionizer.sh"

      # Open 'DOCUMENTATION' in Tmux session
      bind-key -r y run-shell "~/.config/tmux/tmux-sessionizer.sh ~/Code/tgallacher/obsidian"

      # Open 'DOTFILES' in Tmux session
      bind-key -r u run-shell "~/.config/tmux/tmux-sessionizer.sh ~/Code/tgallacher/dotfiles"


      ### STATUS BAR customization
      set -g status-position top
      set -g status-interval 10         # update the status bar every 10 seconds
      set -g status-justify left
      set -g status-left-length 200     # increase length (from 10)
      set -g status-style 'bg=default'  # transparent background

      set -g status-left "#[fg=${theme.text},bg=${theme.trans}]  #S #[fg=${theme.text},bg=${theme.trans}]|"
      set -g window-status-format '#[fg=${theme.text},bg=${theme.trans}] #I.#W #[fg=${theme.text},bg=${theme.trans}]#{?window_zoomed_flag,,}'
      set -g window-status-current-format '#[fg=${theme.primary},bg=${theme.trans}] #I.#W #[fg=${theme.secondary},bg=${theme.trans}]#{?window_zoomed_flag,,}'

      set -g pane-border-style 'fg=${theme.text}'
      set -g pane-active-border-style 'fg=${theme.primary}'
      set -g window-status-last-style 'fg=white,bg=${theme.trans}'
      set -g message-command-style fg=${theme.secondary},bg=${theme.trans}
      set -g message-style fg=${theme.secondary},bg=${theme.trans}
      set -g mode-style fg=${theme.secondary},bg=terminal
      set -gp window-style bg=terminal
    '';
    plugins = lib.mkMerge [
      (lib.mkBefore [upkgs.tmuxPlugins.sensible])
      [
        upkgs.tmuxPlugins.yank
        upkgs.tmuxPlugins.sessionist
        upkgs.tmuxPlugins.vim-tmux-navigator
        {
          plugin = upkgs.tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'

            # Hack: `extraConfig` is inserted after plugins, but continuum plugin needs to come after anything that edits `status-right`
            # see: https://github.com/nix-community/home-manager/issues/3555
            set -g status-right "#[fg=${theme.text},bg=${theme.trans}]|#[fg=${theme.text},bg=${theme.trans}] %Y-%m-%d "
          '';
        }
        {
          # Note: must come after anything that edits the right status bar
          plugin = upkgs.tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ]
    ];
  };
}
