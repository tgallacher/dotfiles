-- INFO: this file is auto-reloaded on save
local wezterm = require("wezterm")

-- see: https://wezterm.org/config/lua/wezterm
return {
  -- color_scheme = "Kanagawa Dragon (Gogh)",
  -- color_scheme = "Tokyo Night",
  color_scheme = "rose-pine",
  disable_default_key_bindings = true, -- lets us use alternative file keymap, etc
  enable_kitty_keyboard = false,
  check_for_updates = false,
  cursor_blink_rate = 500,
  enable_tab_bar = false,
  use_ime = false,
  window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW",
  window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.25cell",
    bottom = 0,
  },
  -- Fonts
  font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" }),
  font_size = 14,
  line_height = 1.00,
  use_dead_keys = false,
  -- Appearance
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 1,
  send_composed_key_when_left_alt_is_pressed = false,
  -- Key binds
  keys = {
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    {
      key = "m",
      mods = "CMD",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "3",
      mods = "ALT",
      action = wezterm.action.SendString("#"),
    },
    {
      key = "c",
      mods = "SUPER",
      action = wezterm.action.CopyTo("Clipboard"),
    },
    {
      key = "v",
      mods = "SUPER",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      key = "x",
      mods = "SUPER",
      action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
  },
}
