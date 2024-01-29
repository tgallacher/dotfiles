local icons = require("user.config.icons")

return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/noice.nvim" },
    opts = function()
      -- local mode = {
      -- 	"mode",
      -- 	fmt = function(str)
      -- 		return "-- " .. str .. " --"
      -- 	end,
      -- }

      local spaces = function() return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = icons.ui.Close .. " ",
          warn = icons.diagnostics.Warning .. " ",
        },
        colored = false,
        update_in_insert = false,
        always_visible = true,
      }

      return {
        options = {
          -- theme = "iceberg_dark",
          -- TODO: migrate catpuccin coloscheme
          -- theme = "nightfly",
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
          gloabalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            diagnostics,
            {
              "buffers",
              use_mode_colors = false,
              buffers_color = {
                active = { fg = "#c6a0f6" }, -- Color for active buffer.
              },
            },
            "diff",
          },
          lualine_c = {},
          lualine_x = {
            -- {
            --   require("noice").api.status.message.get_hl,
            --   cond = require("noice").api.status.message.has,
            -- },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
            },
          },
          lualine_y = { spaces, "filetype", "progress", "location" },
          lualine_z = { "branch" },
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
