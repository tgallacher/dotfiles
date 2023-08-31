--
-- Plugin: "nvim-treesitter/nvim-treesitter"
--
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("Failed to load treesitter")
	return
end

treesitter.setup({
	ensure_installed = { -- put the language you want in this array
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
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = { enable = true },
	autotag = { enable = true },
	indent = {
		enable = true,
		disable = { "python", "css" },
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	-- ensure_installed = "all", -- one of "all" or a list of languages
	-- ignore_install = { "" },  -- List of parsers to ignore installing
	sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
	auto_install = true,
})
