local packer = require "user.utils.packer"

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
  use { 
    "wbthomason/packer.nvim",     -- Have packer manage itself
    requires = {
      "nvim-lua/plenary.nvim"     -- Useful lua functions used by lots of plugins
    }
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
  }  

	-- Cmp 
  use "hrsh7th/nvim-cmp"          -- The completion plugin
  use "hrsh7th/cmp-buffer"        -- buffer completions
  use "hrsh7th/cmp-path"          -- path completions
  use "hrsh7th/cmp-cmdline"       -- command line completions
	use "hrsh7th/cmp-nvim-lsp" 
	use "hrsh7th/cmp-nvim-lua" 

	-- Snippets
  use "L3MON4D3/LuaSnip"              --snippet engine
	use "saadparwaiz1/cmp_luasnip"      -- snippet completions
  use "rafamadriz/friendly-snippets"  -- a bunch of snippets to use

	-- LSP
  use { 
    "neovim/nvim-lspconfig",                -- LSP Configuration & Plugins
    requires = {
      "williamboman/mason.nvim",            -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",    -- for formatters and linters
      "RRethy/vim-illuminate",              -- highlight repeat occurances of token under cursor inside buffer
      "j-hui/fidget.nvim",                  -- Useful status updates for LSP
    }
  }

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }

	-- Git
	use "lewis6991/gitsigns.nvim"
  use "ThePrimeagen/git-worktree.nvim"

  use "tpope/vim-surround"
  use "ThePrimeagen/harpoon"
  use "folke/twilight.nvim"

  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",             -- Optional
    }
  }

  use { 
    "folke/trouble.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }

  use { 
    "folke/todo-comments.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    }
  }

  use "windwp/nvim-autopairs"     -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" 
--  use "JoosepAlviste/nvim-ts-context-commentstring"
  use { 
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }
  -- use "akinsho/bufferline.nvim"     -- Tabs 
  -- use "moll/vim-bbye" 
  use "ojroques/nvim-bufdel"
  use "nvim-lualine/lualine.nvim"
  use "christoomey/vim-tmux-navigator"
  -- use "akinsho/toggleterm.nvim" 
  use "ahmedkhalf/project.nvim" 
  use "lukas-reineke/indent-blankline.nvim"
--  use "goolord/alpha-nvim"        -- Custom NVim dashboard
	use "folke/which-key.nvim"

	-- Colorschemes
  use "cocopon/iceberg.vim"

  -- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

