{ self
, upkgs
, config
, ...
}: {
  programs.tmux =
    let
      theme = {
        trans = "default";
        grey = "#${config.colorScheme.palette.base03}";
        text = "#${config.colorScheme.palette.base04}";
        primary = "#${config.colorScheme.palette.base07}";
        accent = "#${config.colorScheme.palette.base0A}";
      };
    in
    {
      enable = true;
      package = upkgs.tmux;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = false;
      keyMode = "vi";
      mouse = true;
      prefix = "C-b";
      terminal = "tmux-256color";
      extraConfig = ''
        set-option -g focus-events on
        set-option -sg escape-time 10

        # set-option -g renumber-windows on             # Re-number remaining windows when one is closed
        unbind -T copy-mode-vi MouseDragEnd1Pane        # don't exit copy mode when dragging with mouse

        ## vim keys to switch windows
        bind -n M-h previous-window
        bind -n M-l next-window

        ## Keep zoom when moving up/down panes
        bind-key -n M-k select-pane -U \; resize-pane -Z
        bind-key -n M-j select-pane -D \; resize-pane -Z

        ## Easier window split + retain cwd
        unbind '"'
        bind v split-window -v -c "#{pane_current_path}"
        unbind %
        bind h split-window -h -c "#{pane_current_path}"

        ## Easy config reload
        bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded..."

        # Set copy mode to immitate Vim keybindings.
        # Here we adjust the key bind to the copy-mode-vi table in tmux, eg. does not require prefix
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        ## STATUS BAR customization
        set -g status-position top
        set -g status-interval 10         # update the status bar every 10 seconds
        set -g status-justify left
        set -g status-left-length 200     # increase length (from 10)
        set -g status-style 'bg=default'  # transparent background

        set -g status-left "#[fg=${theme.primary},bg=${theme.trans}]  #S #[fg=${theme.grey},bg=${theme.trans}]|"
        set -g window-status-format '#[fg=${theme.text},bg=${theme.trans}] #I.#W'
        set -g window-status-current-format '#[fg=${theme.accent},bg=${theme.trans}] #I.#W'

        set -g pane-border-style 'fg=${theme.primary}'
        set -g pane-active-border-style 'fg=${theme.primary}'
        set -g window-status-last-style 'fg=white,bg=${theme.trans}'
        set -g message-command-style fg=${theme.accent},bg=${theme.trans}
        set -g message-style fg=${theme.accent},bg=${theme.trans}
        # set -g mode-style fg=${theme.accent},bg=${theme.trans}
        set -g mode-style fg=${theme.accent},bg=terminal
        set -gp window-style bg=terminal
      '';
      plugins = with upkgs; [
        tmuxPlugins.yank
        tmuxPlugins.sessionist
        tmuxPlugins.vim-tmux-navigator
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'

            # Hack: `extraConfig` is inserted after plugins, but continuum plugin needs to come after anything that edits `status-right`
            set -g status-right "#[fg=${theme.accent},bg=${theme.trans}]#{?window_zoomed_flag, ,} #[fg=${theme.grey},bg=${theme.trans}]|#[fg=${theme.primary},bg=${theme.trans}] %Y-%m-%d "
          '';
        }
        # Note: must come after catpuccin, or anything that edits the right status bar
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = "set -g @continuum-restore 'on'";
        }
      ];
    };
}
