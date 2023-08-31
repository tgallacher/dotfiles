-- Autoload packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Failed to load packer..")
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install plugins here
return packer.startup(function(use)
  -- ====== CORE ====== --
  use "wbthomason/packer.nvim"      -- Have packer manage itself
  use "nvim-lua/plenary.nvim"       -- Useful lua functions used by lots of plugins

  use "nvim-tree/nvim-web-devicons" -- [optional]: nice icons for filetypes, etc
  use "nvim-tree/nvim-tree.lua"

  use "MunifTanjim/nui.nvim"                                  -- [optional]: core ui library, use by many plugins
  use "rcarriga/nvim-notify"                                  -- [optional]:

  use "tpope/vim-repeat"                                      -- support repeat cmds from plugins using the "." char
  use "tpope/vim-surround"                                    -- make surrounding text faster
  use "windwp/nvim-autopairs"                                 -- autoclose parens, brackets, quotes, etc
  use "numToStr/Comment.nvim"                                 -- toggle comment lines/blocks, gcc or gbc etc
  use "ojroques/nvim-bufdel"                                  -- Easier management of buffers
  use "christoomey/vim-tmux-navigator"                        -- consistent window nav with Tmux

  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" } -- autoclose tags

  -- ====== Language Integrations ====== --
  -- completions
  use "hrsh7th/nvim-cmp"    -- The completion plugin
  use "hrsh7th/cmp-buffer"  -- buffer completions
  use "hrsh7th/cmp-path"    -- path completions
  use "hrsh7th/cmp-cmdline" -- command line completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "jose-elias-alvarez/typescript.nvim"          -- additional func. for TS (rename, update imports, etc)
  use "onsails/lspkind.nvim"                        -- vs-code like icons for autocompletion
  use "JoosepAlviste/nvim-ts-context-commentstring" -- auto detect commentstring type based on cursor position

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "saadparwaiz1/cmp_luasnip"     -- snippet completions
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- lsp
  use "williamboman/mason.nvim"                   -- Automatically install LSPs to stdpath for neovim
  use "williamboman/mason-lspconfig.nvim"
  use "jay-babu/mason-null-ls.nvim"               -- bridges gap b/w mason & null-ls
  use "neovim/nvim-lspconfig"                     -- LSP Configuration & Plugins
  use { "glepnir/lspsaga.nvim", branch = "main" } -- enhanced lsp uis
  use "jose-elias-alvarez/null-ls.nvim"           -- for formatters and linters
  use "RRethy/vim-illuminate"                     -- highlight repeat occurances of token under cursor inside buffer
  -- use { "j-hui/fidget.nvim", tag = "legacy" }         -- status updates from LSP clients

  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } -- dependency for better sorting performance
  use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }


  use {
    "nvim-treesitter/nvim-treesitter", -- Syntax parser for highlighting
    requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }


  -- ====== Visuals ====== --
  use "lewis6991/gitsigns.nvim"
  use "nvim-lualine/lualine.nvim"     -- bottom status bar
  use "cocopon/iceberg.vim"           -- colorscheme
  use "bluz71/vim-nightfly-guicolors" -- colorscheme
  use "jaredgorski/spacecamp"         -- colorscheme
  use "lukas-reineke/indent-blankline.nvim"
  use "wadackel/vim-dogrun"           -- colorscheme
  use {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end
  }


  -- ====== Misc ====== --
  -- use "ThePrimeagen/harpoon"
  use "folke/twilight.nvim"
  use "folke/noice.nvim"
  -- use "folke/trouble.nvim"
  use "folke/todo-comments.nvim"
  use "folke/zen-mode.nvim"
  use "f-person/git-blame.nvim"

  -- use "akinsho/toggleterm.nvim"
  -- use "goolord/alpha-nvim"        -- Custom NVim dashboard
  -- use "ahmedkhalf/project.nvim"
  use "folke/which-key.nvim"

  -- use "ThePrimeagen/git-worktree.nvim"


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
