local wezterm = require("wezterm")

return {
  color_scheme = "Rosé Pine (base16)",
  -- Fonts
  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
  font_size = 13,
  line_height = 1.10,
  -- Appearance
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 0.95,
  send_composed_key_when_left_alt_is_pressed = false,
  -- Key binds
  keys = {},
}
