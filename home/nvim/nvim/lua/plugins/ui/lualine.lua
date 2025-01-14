-- Display if buffer has been Harpoon'd
-- source: https://github.com/dmmulroy/kickstart.nix
local function harpoon()
  local hp = require("harpoon")

  -- format buf to match harpoon2
  local function _make_buf_path_relative(root_dir)
    local Path = require("plenary.path")
    local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

    return Path:new(buf_name):make_relative(root_dir)
  end

  -- find cur buf location in list (if present)
  local function _get_cur_buf_mark()
    local cur_buf_rel_name = _make_buf_path_relative(hp.config.default.get_root_dir())
    local current_mark = "—"

    local _, mark_idx = hp:list():get_by_value(cur_buf_rel_name)
    if mark_idx ~= nil then
      current_mark = tostring(mark_idx)
    end

    return current_mark
  end

  local total_marks = hp:list():length()
  if total_marks == 0 then
    return ""
  end

  return string.format("󰛢 %s/%d", _get_cur_buf_mark(), total_marks)
end

return {
  { -- statusline
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return {
        options = {
          -- theme = "tokyonight",
          icons_enabled = true,
          component_separators = { left = "", right = "" }, -- remove default separators
          section_separators = { left = "", right = "" }, -- remove default separators
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "winbar" },
          gloabalstatus = false,
          always_divide_middle = true,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        },
        sections = {
          lualine_a = {
            { "mode" },
          },
          lualine_b = {
            harpoon,
            -- {
            --   "buffers",
            --   use_mode_colors = false,
            -- },
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 4,
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
