{
  self,
  upkgs,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    package = upkgs.tmux;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = false;
    keyMode = "vi";
    mouse = true;
    prefix = "C-t";
    terminal = "xterm-256color";
    extraConfig = ''
      # set-option -g renumber-windows on             # Re-number remaining windows when one is closed
      set -g status-position top

      unbind -T copy-mode-vi MouseDragEnd1Pane        # don"t exit copy mode when dragging with mouse

      # vim keys to switch windows
      bind -n M-h previous-window
      bind -n M-l next-window

      # Keep zoom when moving up/down panes
      bind-key -n M-k select-pane -U \; resize-pane -Z
      bind-key -n M-j select-pane -D \; resize-pane -Z

      # Easier window split + retain cwd
      unbind '"'
      bind v split-window -v -c "#{pane_current_path}"
      unbind %
      bind h split-window -h -c "#{pane_current_path}"

      # Easy config reload
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded..."

      # Set copy mode to immitate Vim keybindings.
      # Here we adjust the key bind to the copy-mode-vi table in tmux, eg. does not require prefix
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
    plugins = with upkgs; [
      tmuxPlugins.yank
      tmuxPlugins.sessionist
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "mocha"
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%Y-%m-%d %H:%M"
          set -g @catppuccin_window_status_enable "no"
          set -g @catppuccin_window_status_icon_enable "yes"
          set -g @catppuccin_icon_window_last "󰖰"
          set -g @catppuccin_icon_window_current "󰖯"
          set -g @catppuccin_icon_window_zoom "󰁌"
          set -g @catppuccin_icon_window_mark "󰃀"
          set -g @catppuccin_icon_window_silent "󰂛"
          set -g @catppuccin_icon_window_activity "󰖲"
          set -g @catppuccin_icon_window_bell "󰂞"


          # set -g @catppuccin_window_current_format_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_window_default_fill "none"  # all | number | none
          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_fill "icon" # icon | all
          set -g @catppuccin_status_connect_separator "no" # disable blending of the separator to tmux bg
          set -g @catppuccin_status_modules_left "session"
          # opts: application | directory | session | user | host | date_time | battery
          set -g @catppuccin_status_modules_right "application directory date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█ "

          set -g @catppuccin_application_color "#e27878"
          set -g @catppuccin_directory_color "#a093c7"
          set -g @catppuccin_session_color "#b4be82"
          set -g @catppuccin_date_time_color "#84a0c6"
        '';
      }
      # Note: must come after catpuccin, or anything that edits the right status bar
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
  };
}
