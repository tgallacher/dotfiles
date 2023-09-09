local icons = require("user.plugins.config").icons

return {
	-- git visuals / actions
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>gb", function() gs.blame_line({ full = true }) end)
				map("n", "<leader>gbt", gs.toggle_current_line_blame)
			end,
			signs = {
				add = { text = icons.add },
				change = { text = icons.change },
				delete = { text = icons.delete },
				topdelete = { text = icons.delete },
				changedelete = { text = icons.change },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter_opts = {
				relative_time = true,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = { enable = false },
		},
	},
}
