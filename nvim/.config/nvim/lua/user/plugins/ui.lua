return {
  -- filetype icons, used by many plugins
  { "nvim-tree/nvim-web-devicons" },

  -- dim inactive code sections
  {
    "folke/twilight.nvim",
    opts = {},
    keys = {
      { "<leader>tw", ":Twilight <CR>", "n", { noremap = true, silent = true } },
    },
  },

  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    opts = {},
    keys = {
      { "<leader>zm", ":ZenMode <CR>", "n", { noremap = true, silent = true } },
    },
  },

  -- core ui library used by various plugins
  "MunifTanjim/nui.nvim",

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

  --
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false,    -- use a classic bottom cmdline for search
        command_palette = true,   -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,       -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,   -- add a border to hover docs and signature help
      },
      views = {
        -- cmdline_popupmenu = {
        --   position = "50%"
        -- },
        cmdline_popup = {
          position = "50%",
          size = {
            min_width = 120,
            -- width = 420,
            -- border = {
            --   style = "none"
            -- }
          },
        },
      },
    },
  },

  -- visualise hex codes
  {
    "norcalli/nvim-colorizer.lua",
    main = "colorizer",
    opts = {},
  },
}
