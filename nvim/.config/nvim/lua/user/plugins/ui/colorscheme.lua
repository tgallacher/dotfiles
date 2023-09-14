return {
  -- different theme per filetype
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup {
        themes = {
          markdown = { colorscheme = "nightlfy" },
          help = { colorscheme = "catppuccin" },
        },
      }
    end,
  },

	-- nightfly
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		-- priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme nightfly]])
  --   end
  },

  { 
    'rose-pine/neovim', 
    name = 'rose-pine',
		lazy = false,
		priority = 1000,
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end
  },

  { 
    "cocopon/iceberg.vim",
    lazy = true,
  },

	{ "jaredgorski/spacecamp", lazy = true },

	{ "wadackel/vim-dogrun", lazy = true },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
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
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
