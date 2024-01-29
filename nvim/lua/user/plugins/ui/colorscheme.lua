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
    enabled = false,
    lazy = false,
    -- priority = 1000,
    -- config = function() vim.cmd([[colorscheme rose-pine]]) end,
  },

  { "cocopon/iceberg.vim", enabled = false, lazy = true },
  { "wadackel/vim-dogrun", enabled = false, lazy = true },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function() vim.cmd([[colorscheme catppuccin-mocha]]) end,
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = false,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
