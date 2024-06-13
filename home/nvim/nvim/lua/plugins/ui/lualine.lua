-- local colors = require("catppuccin.palettes.mocha")
-- local color_utils = require("catppuccin.utils.colors")

-- Display if buffer has been Harpoon'd
--
-- source: https://github.com/dmmulroy/kickstart.nix
local function harpoon()
  local hp = require("harpoon.mark")
  local total_marks = hp.get_length()

  if total_marks == 0 then
    return ""
  end

  local current_mark = "—"
  local mark_idx = hp.get_current_index()
  if mark_idx ~= nil then
    current_mark = tostring(mark_idx)
  end

  return string.format("󰛢 %s/%d", current_mark, total_marks)
end

return {
  { -- statusline
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- FIXME: Overwrites default startup dashboard and injects `[no name]` buffer.
    -- Can use Alpha plugin as a workaround to control custom dashboard.
    --
    -- enabled = false,
    -- event = "StdinReadPre",
    -- lazy = true,
    opts = function()
      return {
        options = {
          theme = "rose-pine",
          icons_enabled = true,
          component_separators = { left = "", right = "" }, -- remove default separators
          section_separators = { left = "", right = "" }, -- remove default separators
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "winbar" },
          gloabalstatus = true,
          always_divide_middle = true,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              -- separator = { left = "", right = "" },
              -- color = {
              --   fg = colors.base,
              --   bg = colors.mauve,
              -- },
            },
          },
          lualine_b = {
            harpoon,
            {
              "buffers",
              use_mode_colors = false,
              -- separator = { left = "", right = "" },
              -- buffers_color = {
              --   active = { fg = colors.mauve, bg = colors.mantle },
              --   inactive = { fg = colors.overlay0, bg = colors.mantle },
              -- },
            },
          },
          lualine_c = {},
          lualine_x = {
            {
              "diff",
              draw_empty = true,
              -- separator = { left = "", right = "" },
              -- color = { bg = colors.surface0 },
              -- diff_colors = {
              --   added = colors.green,
              --   modified = colors.yellow,
              --   removed = colors.red,
              -- },
            },

            {
              "branch",
              icon = "󰘬",
              -- separator = { left = "", right = "" },
              -- color = {
              --   -- fg = colors.text,
              --   -- -- bg = color_utils.darken(colors.mauve, 0.55),
              --   -- fg = colors.overlay2,
              --   -- bg = colors.base,
              -- },
            },
          },
          lualine_y = {
            -- {
            --   "filesize",
            --   separator = { left = "", right = "" },
            --   -- color = {
            --   --   fg = colors.overlay2,
            --   --   bg = colors.crust,
            --   -- },
            -- },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn" },
              -- separator = { left = "", right = "" },
              symbols = { error = " ", warn = " " },
              -- diagnostics_colors = {
              --   error = colors.red,
              --   warn = colors.yellow,
              -- },
              colored = true,
              update_in_insert = false,
              always_visible = true,
              -- color = {
              --   bg = colors.mantle,
              -- },
            },
          },
          lualine_z = {
            {
              "filetype",
              -- separator = { left = "", right = "" },
              colored = false, -- icon only
              -- color = {
              --   fg = colors.overlay1,
              --   bg = colors.base,
              -- },
            },
            {
              "progress",
              -- separator = { left = "", right = "" },
              -- color = {
              --   fg = colors.subtext1,
              --   bg = colors.surface0,
              -- },
            },
            {
              "location",
              -- color = {
              --   fg = colors.text,
              --   bg = colors.surface1,
              -- },
            },
          },
        },
        extensions = {
          "lazy",
          "nvim-tree",
          "toggleterm",
        },
      }
    end,
  },
}
