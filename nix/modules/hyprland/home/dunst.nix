{
  self,
  inputs,
  system,
  config,
  ...
}: {
  services.dunst = {
    enable = true;
    package = inputs.nixpkgs-wayland.packages.${system}.dunst;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 300;
        height = "(0, 300)";
        origin = "top-center";
        scale = 0;
        offset = "0x30";
        notification_limit = 5;
        progress_bar = true; # Appears when using e.g. `notify-send -h int:value:12`
        progress_bar_height = 12;
        progress_bar_frame_width = 1;
        progrss_bar_min_width = 150;
        progrss_bar_max_width = 300;
        indicate_hidden = true;
        separate_height = 0;
        padding = 0; # vertical padding (e.g. between text and separator)
        horizontal_padding = 5;
        text_icon_padding = 0;
        frame_width = 2; # border size
        frame_color = "#fff";
        gap_size = 3; # between notifications
        sort = true;
        font = "JetBrainsMono Nerd Font Mono 14";
        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        #   %n  progress value if set without any extra characters
        #   %%  Literal %
        # Markup is allowed
        markup = "full"; # don't strip html
        format = "<b>%s</b>\n%b";
        alignment = "left";
        show_age_threshold = 120; # time (s) before age is shown
        ellipsize = "end";
        ignore_newline = false;
        show_indicators = true;
        enable_recursive_icon_lookup = true;
        min_icon_size = 16;
        max_icon_size = 32;
        corner_radius = 0;
        # Defines list of actions for each mouse event
        # Possible values are:
        #   * none: Don't do anything.
        #   * do_action: Invoke the action determined by the action_name rule. If there is no
        #                such action, open the context menu.
        #   * open_url: If the notification has exactly one url, open it. If there are multiple
        #               ones, open the context menu.
        #   * close_current: Close current notification.
        #   * close_all: Close all notifications.
        #   * context: Open context menu for the notification.
        #   * context_all: Open context menu for all notifications.
        # These values can be strung together for each mouse event, and
        # will be executed in sequence.
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
    };
  };
}
