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
    opts = function()
      return {
        options = {
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
            { "mode" },
          },
          lualine_b = {
            harpoon,
            {
              "buffers",
              use_mode_colors = false,
            },
          },
          lualine_c = {},
          lualine_x = {
            {
              "diff",
              draw_empty = true,
              -- diff_colors = {
              --   added = colors.green,
              --   modified = colors.yellow,
              --   removed = colors.red,
              -- },
            },

            {
              "branch",
              icon = "󰘬",
            },
          },
          lualine_y = {
            -- { "filesize", },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn" },
              symbols = { error = " ", warn = " " },
              -- diagnostics_colors = {
              --   error = colors.red,
              --   warn = colors.yellow,
              -- },
              colored = true,
              update_in_insert = false,
              always_visible = true,
            },
          },
          lualine_z = {
            {
              "filetype",
              colored = false, -- icon only
            },
            { "progress" },
            { "location" },
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
