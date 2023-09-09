return {
	-- token parser
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- mainline
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		opts = {
			ensure_installed = {
				"lua",
				"markdown",
				"markdown_inline",
				"bash",
				"javascript",
				"typescript",
				"jsdoc",
				"graphql",
				"vimdoc",
				"terraform",
				"dockerfile",
				"nix",
				"yaml",
				"prisma",
				"json",
				"tsx",
				"vim",
				"gitignore",
				"kconfig",
				"devicetree",
			},
			highlight = {
				enable = true, 
				disable = { "css" }, 
			},
			autopairs = { enable = true },
			autotag = { enable = true },
			indent = {
				enable = true,
				disable = { "python", "css" },
			},
      illuminate = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			auto_install = true,
		},
	},
}
