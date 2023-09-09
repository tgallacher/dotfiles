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

      local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = " ",
          warn  = " ",
        },
        colored = false,
        update_in_insert = false,
        always_visible = true,
      }

      -- local colors = require("user.plugins.colorscheme.colors")

      return {
        options = {
          -- theme = "iceberg_dark",
          theme = "nightfly",
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
          disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { diagnostics, "buffers", "diff" },
          lualine_x = {
            -- {
            --   require("noice").api.status.message.get_hl,
            --   cond = require("noice").api.status.message.has,
            -- },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              -- color = { fg = colors.color_6 },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              -- color = { fg = colors.color_6 },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              -- color = { fg = colors.color_6 },
            },
          },
          lualine_y = { spaces, "filetype", "progress", "location" },
          lualine_z = { "branch" },
        },
      }
    end,
  },
} 
