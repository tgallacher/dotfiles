{
  self,
  config,
  ...
}: let
  customRofiThemeLoaderPath = "${config.xdg.dataHome}/rofi/themes/rofi-pywal";
in {
  home.file."${customRofiThemeLoaderPath}.rasi".text = ''
    /*
      Load pywal color definitions.
      see: `pywal.nix`
    */
    @import "${config.xdg.cacheHome}/wal/colors-rofi-pywal"
    @import "${config.xdg.cacheHome}/wal/colors-rofi-dark"
  '';

  # Note: Element layout can be found under "Layout" section within `man 5 rofi-theme`
  programs.rofi.theme = let
    # Use `mkLiteral` for string-like values that should show without quotes, e.g.:
    inherit (config.lib.formats.rasi) mkLiteral;
  in {
    # Note: Workaround for not being able to figure out how to load multiple `@import` here
    # see above
    "@import" = "${customRofiThemeLoaderPath}";

    # define additional vars for reuse
    "*" = {
      borderRadius = mkLiteral "4px";
      accent = mkLiteral "@color1";
    };

    window = {
      width = mkLiteral "900px";
      x-offset = mkLiteral "0px";
      y-offset = mkLiteral "0px";
      spacing = mkLiteral "0px";
      padding = mkLiteral "0px";
      margin = mkLiteral "0px";
      color = mkLiteral "@foreground";
      border = mkLiteral "1px";
      border-color = mkLiteral "@foreground";
      cursor = "default";
      transparency = "real";
      location = mkLiteral "center";
      anchor = mkLiteral "center";
      fullscreen = false;
      enabled = true;
      border-radius = mkLiteral "@borderRadius";
      background-color = mkLiteral "transparent";
    };

    mainbox = {
      enabled = true;
      orientation = mkLiteral "vertical";
      spacing = mkLiteral "0px";
      margin = mkLiteral "0px";
      padding = mkLiteral "0px";
      background-color = mkLiteral "@background";
      children = map mkLiteral ["inputbar" "listbox"];
    };

    ###################
    ## INPUT SEARCH  ##
    ###################
    inputbar = {
      enabled = true;
      text-color = mkLiteral "@accent";
      spacing = mkLiteral "0px";
      padding = mkLiteral "15px";
      border-radius = mkLiteral "@borderRadius";
      border-color = mkLiteral "@foreground";
      background-color = mkLiteral "@background";
      children = map mkLiteral ["textbox-prompt-colon" "entry"];
    };

    textbox-prompt-colon = {
      # content = "";
      content = "";
      enabled = true;
      expand = false;
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
    };

    entry = {
      enabled = true;
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
      cursor = mkLiteral "text";
      placeholder = "Search...";
      placeholder-color = mkLiteral "inherit";
    };

    ###################
    ## MODE SWITCHER ##
    ###################
    mode-switcher = {
      enabled = false;
      spacing = mkLiteral "20px";
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "@foreground";
    };

    button = {
      padding = mkLiteral "10px";
      border-radius = mkLiteral "@borderRadius";
      background-color = mkLiteral "@background";
      text-color = mkLiteral "inherit";
      cursor = mkLiteral "pointer";
      border = mkLiteral "0px";
    };

    "button selected" = {
      background-color = mkLiteral "@color11";
      text-color = mkLiteral "@accent";
    };

    ###################
    ## RESULTS LIST  ##
    ###################
    listbox = {
      spacing = mkLiteral "20px";
      background-color = mkLiteral "transparent";
      orientation = mkLiteral "vertical";
      children = map mkLiteral ["message" "listview"];
    };

    listview = {
      enabled = true;
      columns = 1;
      lines = 8;
      cycle = true;
      dynamic = true;
      scrollbar = false;
      layout = mkLiteral "vertical";
      reverse = false;
      fixed-height = true;
      fixed-columns = true;
      spacing = mkLiteral "2px";
      padding = mkLiteral "10px";
      margin = mkLiteral "0px";
      background-color = mkLiteral "transparent";
      border = mkLiteral "0px";
    };

    element = {
      enabled = true;
      padding = mkLiteral "5px";
      margin = mkLiteral "0px";
      cursor = mkLiteral "pointer";
      background-color = mkLiteral "inherit";
      border-radius = mkLiteral "@borderRadius";
      border = mkLiteral "1px";
    };

    "element normal.normal" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element normal.urgent" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element normal.active" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element selected.normal" = {
      background-color = mkLiteral "@accent";
      text-color = mkLiteral "@background";
    };

    "element selected.urgent" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element selected.active" = {
      background-color = mkLiteral "@accent";
      text-color = mkLiteral "@background";
    };

    "element alternate.normal" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element alternate.urgent" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element alternate.active" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    element-icon = {
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
      size = mkLiteral "32px";
      cursor = mkLiteral "inherit";
    };

    element-text = {
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
      cursor = mkLiteral "inherit";
      vertical-align = mkLiteral "0.5";
      horizontal-align = mkLiteral "0.0";
    };

    ################
    ## MESAGE BOX ##
    ################
    message = {
      background-color = mkLiteral "transparent";
      border = mkLiteral "0px";
      margin = mkLiteral "20px 0px 0px 0px";
      padding = mkLiteral "0px";
      spacing = mkLiteral "0px";
      border-radius = mkLiteral "@borderRadius";
    };

    textbox = {
      padding = mkLiteral "15px";
      margin = mkLiteral "0px";
      border-radius = mkLiteral "0px";
      background-color = mkLiteral "@background";
      text-color = mkLiteral "@foreground";
      vertical-align = mkLiteral "0.5";
      horizontal-align = mkLiteral "0.0";
    };

    error-message = {
      padding = mkLiteral "15px";
      border-radius = mkLiteral "20px";
      background-color = mkLiteral "@background";
      text-color = mkLiteral "@foreground";
    };
  };
}
