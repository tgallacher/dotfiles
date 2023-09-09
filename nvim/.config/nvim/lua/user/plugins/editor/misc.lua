return {
	{ "lukas-reineke/indent-blankline.nvim" },
	
  -- toggle comment lines/blocks, gcc or gbc etc
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment = require("Comment")

			comment.setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- Easier management of buffers
	{
		"ojroques/nvim-bufdel",
		event = { "BufReadPre", "BufNewFile" },
    opts = {
      quit = false,
    },
    keys = {
      { "<leader>bc", "<cmd> BufDel<cr>", desc = "Close current buffer" },
      { "<leader>bC", "<cmd> BufDelOthers<cr>", desc = "Close all other buffers" },
    },
	},

	-- autoclose tags
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter" },
		event = { "InsertEnter" },
	},
	
  -- consistent window nav with Tmux
	{
		"christoomey/vim-tmux-navigator",
		config = function()
			return {
				on_attach = function()
					-- Preserve zoom on Tmux navigation
					vim.g.tmux_navigator_preserve_zoom = 1

					vim.keymap.set(
						"n",
						"<C-h>",
						"<cmd> TmuxNavigateLeft<CR>",
						{ noremap = true, silent = true, desc = "Window left" }
					)
					vim.keymap.set(
						"n",
						"<C-l>",
						"<cmd> TmuxNavigateRight<CR>",
						{ noremap = true, silent = true, desc = "Window right" }
					)
					vim.keymap.set(
						"n",
						"<C-j>",
						"<cmd> TmuxNavigateDown<CR>",
						{ noremap = true, silent = true, desc = "Window down" }
					)
					vim.keymap.set(
						"n",
						"<C-k>",
						"<cmd> TmuxNavigateUp<CR>",
						{ noremap = true, silent = true, desc = "Window up" }
					)
				end,
			}
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	{
		"tpope/vim-surround",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- align
	"godlygeek/tabular",

}
