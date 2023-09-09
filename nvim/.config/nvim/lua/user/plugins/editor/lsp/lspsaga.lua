return {
	-- LSP UI
	{
		"glepnir/lspsaga.nvim",
    event = "LspAttach",
		branch = "main",
		-- main = "lspsaga",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- keybinds for navigation in lspsaga window
			scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
			-- use enter to open file with definition preview
			definition = {
				edit = "<CR>",
			},
			ui = {
				colors = {
					normal_bg = "#022746",
				},
			},
			floaterm = {
				width = 0.9,
				height = 0.9,
			},
		},
    config = true,
		keys = {
			{ "<A-d>", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" } },
		},
	},
}
