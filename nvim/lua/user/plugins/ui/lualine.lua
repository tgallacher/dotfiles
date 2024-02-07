local icons = require("user.config.icons")
-- local colors = require("pywal16.core").get_colors()
local colors = require("catppuccin.palettes.mocha")
local color_utils = require("catppuccin.utils.colors")


return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/noice.nvim" },
    opts = function()
      return {
        options = {
          -- theme = "pywal16-nvim",
          theme = "catppuccin",
          icons_enabled = true,
          -- component_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "winbar" },
          gloabalstatus = true,
          always_divide_middle = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              separator = { left = "", right = "" },
              color = {
                fg = colors.base,
                bg = colors.mauve,
              },
            },
            {
              "branch",
              icon = "󰘬",
              separator = { left = "", right = "" },
              color = {
                fg = colors.text,
                bg = color_utils.darken(colors.mauve, 0.55),
              },
            }
          },
          lualine_b = {

            {
              "diff",
              draw_empty = true,
              separator = { left = "", right = "" },
              color = { bg = colors.surface0 },
              diff_colors = {
                added = colors.green,
                modified = colors.yellow,
                removed = colors.red,
              },
            },
            {
              "buffers",
              use_mode_colors = false,
              separator = { left = "", right = "" },
              buffers_color = {
                active = { fg = colors.mauve, bg = colors.mantle },
                inactive = { fg = colors.overlay0, bg = colors.mantle },
              },
            },
          },
          lualine_c = {},
          lualine_x = { },
          lualine_y = {
            {
              "filesize",
              separator = { left = "", right = "" },
              color = {
                fg = colors.overlay2,
                bg = colors.crust,
              },
            },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn" },
              separator = { left = "", right = "" },
              symbols = {
                error = icons.ui.Close .. " ",
                warn = icons.diagnostics.Warning .. " ",
              },
              diagnostics_colors = {
                error = colors.red,
                warn = colors.yellow,
              },
              colored = true,
              update_in_insert = false,
              always_visible = true,
              color = {
                bg = colors.mantle,
              },
            },
          },
          lualine_z = {
            {
              "filetype",
              separator = { left = "", right = "" },
              colored = false, -- icon only
              color = {
                fg = colors.overlay1,
                bg = colors.base,
              },
            },
            {
              "progress",
              separator = { left = "", right = "" },
              color = {
                fg = colors.subtext1,
                bg = colors.surface0,
              },
            },
            {
              "location",
              color = {
                fg = colors.text,
                bg = colors.surface1,
              },
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
