local colors = require("plugins.colors")

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
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          icons_enabled = true,
          component_separators = { left = "", right = "" }, -- remove default separators
          section_separators = { left = "", right = "" }, -- remove default separators
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "winbar" },
          always_divide_middle = true,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
          -- globalstatus = vim.o.laststatus == 3,
          globalstatus = false,
        },
        sections = {
          lualine_a = {
            { "mode" },
          },
          lualine_b = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              -- sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn" },
              symbols = { error = " ", warn = " " },
              colored = true,
              update_in_insert = false,
              always_visible = true,
            },

            harpoon,
            -- {
            --   "buffers",
            --   use_mode_colors = false,
            -- },
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 1,
            },
          },
          lualine_c = {
            {
              -- stylua: ignore
              function() return " " .. require("dap").status() end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
            },
          },
          lualine_x = {
            {
              "diff",
              draw_empty = true,
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              diff_colors = {
                added = colors.git.add,
                modified = colors.git.change,
                removed = colors.git.delete,
              },
            },
            {
              "branch",
              icon = "󰘬",
            },
          },
          lualine_y = {},
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
