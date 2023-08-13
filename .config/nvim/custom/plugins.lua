local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = vim.tbl_deep_extend("force", overrides.mason, {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "denols",
      "dockerfile-language-server",
      "prettier",
      "terraform-ls",
      "yaml-language-server",
      "nix-lsp",
    }),
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = vim.tbl_deep_extend("force", overrides.treesitter, {
      "vim",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "json",
      "bash",
      "dockerfile",
      "nix",
      "terraform",
      "toml",
      "yaml",
    }),
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  { 
    "theprimeagen/harpoon",
    lazy = false 
  },
  --
  -- 
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
