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

  # theme = "${config.xdg.cacheHome}/wal/colors-rofi-dark.rasi";
  # theme = "${config.xdg.cacheHome}/wal/colors-rofi-light.rasi";
  programs.rofi.theme = let
    # Use `mkLiteral` for string-like values that should show without quotes, e.g.:
    # {
    #   foo = "abc"; will result in- foo: "abc";
    #   bar = mkLiteral "abc"; will result in- bar: abc;
    # };
    inherit (config.lib.formats.rasi) mkLiteral;
  in {
    # Note: Workaround for not being able to figure out how to load multiple `@import` here
    "@import" = "${customRofiThemeLoaderPath}";

    window = {
      width = mkLiteral "900px";
      x-offset = mkLiteral "0px";
      y-offset = mkLiteral "0px";
      spacing = mkLiteral "0px";
      padding = mkLiteral "0px";
      margin = mkLiteral "0px";
      color = mkLiteral "#FFFFFF";
      border = mkLiteral "3px";
      border-color = mkLiteral "#FFFFFF";
      cursor = "default";
      transparency = "real";
      location = mkLiteral "center";
      anchor = mkLiteral "center";
      fullscreen = false;
      enabled = true;
      border-radius = mkLiteral "10px";
      background-color = mkLiteral "transparent";
    };

    mainbox = {
      enabled = true;
      orientation = mkLiteral "horizontal";
      spacing = mkLiteral "0px";
      margin = mkLiteral "0px";
      background-color = mkLiteral "@background";
      # background-image = mkLiteral "@current-image";
      children = map mkLiteral ["imagebox" "listbox"];
    };

    imagebox = {
      padding = mkLiteral "18px";
      background-color = mkLiteral "transparent";
      orientation = mkLiteral "vertical";
      children = map mkLiteral ["inputbar" "dummy" "mode-switcher"];
    };

    listbox = {
      spacing = mkLiteral "20px";
      background-color = mkLiteral "transparent";
      orientation = mkLiteral "vertical";
      children = map mkLiteral ["message" "listview"];
    };

    dummy = {
      background-color = mkLiteral "transparent";
    };

    inputbar = {
      enabled = true;
      text-color = mkLiteral "@foreground";
      spacing = mkLiteral "10px";
      padding = mkLiteral "15px";
      border-radius = mkLiteral "10px";
      border-color = mkLiteral "@foreground";
      background-color = mkLiteral "@background";
      children = map mkLiteral ["textbox-prompt-colon" "entry"];
    };

    textbox-prompt-colon = {
      enabled = true;
      expand = false;
      str = "";
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
    };

    entry = {
      enabled = true;
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "inherit";
      cursor = mkLiteral "text";
      placeholder = "Search";
      placeholder-color = mkLiteral "inherit";
    };

    mode-switcher = {
      enabled = true;
      spacing = mkLiteral "20px";
      background-color = mkLiteral "transparent";
      text-color = mkLiteral "@foreground";
    };

    button = {
      padding = mkLiteral "10px";
      border-radius = mkLiteral "10px";
      background-color = mkLiteral "@background";
      text-color = mkLiteral "inherit";
      cursor = mkLiteral "pointer";
      border = mkLiteral "0px";
    };

    "button selected" = {
      background-color = mkLiteral "@color11";
      text-color = mkLiteral "@foreground";
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
      spacing = mkLiteral "0px";
      padding = mkLiteral "10px";
      margin = mkLiteral "0px";
      background-color = mkLiteral "@background";
      border = mkLiteral "0px";
    };

    element = {
      enabled = true;
      padding = mkLiteral "10px";
      margin = mkLiteral "5px";
      cursor = mkLiteral "pointer";
      background-color = mkLiteral "@background";
      border-radius = mkLiteral "10px";
      border = mkLiteral "2px";
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
      background-color = mkLiteral "@color11";
      text-color = mkLiteral "@foreground";
    };

    "element selected.urgent" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
    };

    "element selected.active" = {
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "@foreground";
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

    message = {
      background-color = mkLiteral "transparent";
      border = mkLiteral "0px";
      margin = mkLiteral "20px 0px 0px 0px";
      padding = mkLiteral "0px";
      spacing = mkLiteral "0px";
      border-radius = mkLiteral "10px";
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
