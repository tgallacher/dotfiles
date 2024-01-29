local function setColourScheme(name) vim.cmd("colorscheme " .. name) end

return {
  -- different theme per filetype
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "nightlfy" },
          help = { colorscheme = "catppuccin" },
          ts = { colorscheme = "catppuccin-mocha" },
        },
      })
    end,
  },

  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    enabled = false,
    -- priority = 1000,
    --   config = function()
    --     vim.cmd([[colorscheme nightfly]])
    --   end
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- enabled = false,
    lazy = true,
    -- priority = 1000,
    -- config = function() setColourScheme("rose-pine") end,
  },

  { "cocopon/iceberg.vim", enabled = true, lazy = true },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      setColourScheme("catppuccin-mocha")
    end,
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotest = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
