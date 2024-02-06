local function setColourScheme(name) vim.cmd("colorscheme " .. name) end

return {
  {
    "uZer/pywal16.nvim",
    main = "pywal16",
    priority = 1000,
    lazy = false,
    enabled = false,
    config = function(_, opts)
      require("pywal16").setup(opts)
      setColourScheme("pywal16")
    end,
  },

  -- different theme per filetype
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("styler").setup({
        themes = {
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
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    lazy = true,
  },

  {
    "catppuccin/nvim",
    -- enabled = false,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      setColourScheme("catppuccin-mocha")
    end,
    opts = {
      transparent_background = true,
      no_italic = false,
      no_bold = false,
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
