{
  self,
  config,
  ...
}: {
  programs.waybar.style = ''
    /* Import pywal colors */
    @import "${config.xdg.cacheHome}/wal/colors-waybar.css";

    @define-color bg #fff;
    @define-color bgAlt @color8;
    @define-color accent @color5;
    @define-color textColor @color8;

    /* TODO: Swap these to our names (from ML4W) */
    @define-color backgroundlight @color8;
    @define-color backgrounddark #FFFFFF;
    @define-color workspacesbackground1 @color8;
    @define-color workspacesbackground2 #FFFFFF;
    @define-color bordercolor @color8;
    @define-color textcolor1 @color8;
    @define-color textcolor2 #FFFFFF;
    @define-color textcolor3 #FFFFFF;
    @define-color iconcolor @color8;

    * {
        font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        border: none;
        border-radius: 0px;
    }

    window#waybar {
      background-color: rgba(0,0,0,0.8);
      border-bottom: 0px solid #fff;
      background: transparent;
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    /* -----------------------------------------------------
     * Workspaces
     * ----------------------------------------------------- */

    #workspaces {
        background: @bg;
        margin: 2px 1px 3px 1px;
        padding: 0px 1px;
        border-radius: 15px;
        border: 0px;
        font-weight: bold;
        font-style: normal;
        opacity: 0.8;
        font-size: 14px;
        color: @textColor;
    }

    #workspaces button {
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        color: @textColor;
        background-color: @bgAlt;
        transition: all 0.3s ease-in-out;
        opacity: 0.4;
    }

    #workspaces button.active {
        color: @textColor;
        background-color: @accent;
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity: 1.0;
    }

    #workspaces button:hover {
        color: @textColor;
        background-color: @accent;
        border-radius: 15px;
        opacity: 0.7;
    }

    /* -----------------------------------------------------
     * Taskbar
     * ----------------------------------------------------- */

    #taskbar {
        background: @bg;
        margin: 0px 15px;
        padding: 0px 10px;
        border-radius: 15px;
        font-weight: normal;
        font-style: normal;
        opacity:0.8;
        border: 3px solid @bglight;
    }

    #taskbar button {
        margin:0;
        border-radius: 15px;
        padding: 0px 5px 0px 5px;
    }

    /* -----------------------------------------------------
     * Tooltips
     * ----------------------------------------------------- */

    tooltip {
        border-radius: 10px;
        background-color: @background;
        opacity: 0.8;
        padding: 20px;
        margin: 0px;
    }

    tooltip label {
        color: @textcolor2;
    }

    /* -----------------------------------------------------
     * Window
     * ----------------------------------------------------- */

    #window {
        background: @bglight;
        margin: 5px 15px 5px 0px;
        padding: 2px 10px 0px 10px;
        border-radius: 12px;
        color:@textcolor2;
        font-size:14px;
        font-weight:normal;
        opacity:0.8;
    }

    window#waybar.empty #window {
        background-color:transparent;
    }

    /* -----------------------------------------------------
     * Modules
     * ----------------------------------------------------- */

    .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
    }

    /* -----------------------------------------------------
     * Custom Quicklinks
     * ----------------------------------------------------- */

    #custom-brave,
    #custom-browser,
    #custom-keybindings,
    #custom-outlook,
    #custom-filemanager,
    #custom-teams,
    #custom-chatgpt,
    #custom-calculator,
    #custom-windowsvm,
    #custom-cliphist,
    #custom-wallpaper,
    #custom-settings,
    #custom-wallpaper,
    #custom-system,
    #custom-waybarthemes {
        margin-right: 23px;
        font-size: 20px;
        font-weight: bold;
        opacity: 0.8;
        color: @iconcolor;
    }

    #custom-system {
        margin-right:15px;
    }

    #custom-wallpaper {
      margin-right:25px;
    }

    /* -----------------------------------------------------
     * Idle Inhibator
     * ----------------------------------------------------- */

    #idle_inhibitor {
        margin-right: 15px;
        font-size: 22px;
        font-weight: bold;
        opacity: 0.8;
        color: @iconcolor;
    }

    #idle_inhibitor.activated {
        margin-right: 15px;
        font-size: 20px;
        font-weight: bold;
        opacity: 0.8;
        color: #dc2f2f;
    }

    /* -----------------------------------------------------
     * Custom Modules
     * ----------------------------------------------------- */

    #custom-appmenu, #custom-appmenuwlr {
        background-color: @bgdark;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 0px 10px 0px 10px;
        margin: 3px 15px 3px 14px;
        opacity:0.8;
        border:3px solid @bordercolor;
    }

    /* -----------------------------------------------------
     * Custom Exit
     * ----------------------------------------------------- */

    #custom-exit {
        margin: 0px 20px 0px 0px;
        padding: 0px;
        font-size: 20px;
        color: @iconcolor;
    }

    /* -----------------------------------------------------
     * Hardware Group
     * ----------------------------------------------------- */

    #disk,#memory,#cpu,#bluetooth {
        margin: 0 5px;
        padding: 2px 10px 0px 10px;
        font-size: 14px;
        background-color: @bg;
        border-radius: 15px;
        color: @textColor;
        opacity: 0.8;
    }

    /* -----------------------------------------------------
     * Clock
     * ----------------------------------------------------- */

    #clock {
        background-color: @bg;
        font-size: 14px;
        color: @textColor;
        border-radius: 15px;
        padding: 0px 10px;
        margin: 0 5px;
        opacity: 0.8;
        border:3px solid @accent;
    }

    /* -----------------------------------------------------
     * Pulseaudio
     * ----------------------------------------------------- */

    #pulseaudio {
        background-color: @bg;
        font-size: 14px;
        color: @textColor;
        border-radius: 15px;
        padding: 0px 10px;
        margin: 0 5px;
        opacity: 0.8;
    }

    #pulseaudio.muted {
        background-color: red;
        color: @textColor;
    }

    /* -----------------------------------------------------
     * Network
     * ----------------------------------------------------- */

    #network {
        background-color: @bg;
        font-size: 12px;
        color: @textColor;
        border-radius: 15px;
        padding: 0px 10px;
        margin: 0 5px;
        opacity: 0.8;
    }

    /* -----------------------------------------------------
     * Tray
     * ----------------------------------------------------- */

    #tray {
        padding: 0px 15px 0px 0px;
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
    }
  '';
}
