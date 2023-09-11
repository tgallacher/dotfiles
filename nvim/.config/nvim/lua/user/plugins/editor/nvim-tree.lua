local icons = require("user.config.icons")

return {
  	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		ependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local nvim_tree = require("nvim-tree")
			-- local HEIGHT_RATIO = 0.8 -- Floating window height ratio
			-- local WIDTH_RATIO = 0.5 -- Floating window width ratio

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- vim.opt.foldmethod=expr
			-- vim.opt.foldexpr=nvim_treesitter#foldexpr()

			nvim_tree.setup({
				actions = {
					change_dir = {
						enable = false,
						restrict_above_cwd = true, -- Prevent cd'ing outside cwd
					},
					open_file = {
						quit_on_open = false, -- Close Nvim-tree when opening file
						window_picker = {
							enable = false, -- disable to ensure explorer works well with splits
						},
					},
				},
				disable_netrw = true,
				diagnostics = { -- Show LSP and COC diagnostics in the signcolum
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = false,
					icons = {
						hint = icons.diagnostics.Hint,
						info = icons.diagnostics.Information,
						warning = icons.diagnostics.Warning,
						error = icons.diagnostics.Error,
					},
				},
				filters = {
					dotfiles = false, -- show dotfiles (toggle with `H`)
					-- exclude = {                                  -- Always show these files/dirs (e.g. do not filter them)
					--   vim.fn.stdpath "config" .. "/lua/custom"
					-- },
					custom = { -- Regex to filter (do not show if match)
						"^.git$",
					},
				},
				git = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = false,
				},
				hijack_netrw = true,
				hijack_cursor = true, -- Keeps the cursor on the first letter of the filename when moving in the tree
				hijack_unnamed_buffer_when_opening = false, -- Opens in place of the unnamed buffer if it's empty
				modified = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = false,
				},
				renderer = {
					root_folder_modifier = ":t",
					group_empty = false,
					highlight_opened_files = "icon",
					highlight_modified = "icon",
					symlink_destination = true, -- Show symlink destination
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
						git_placement = "after",
						glyphs = {
							default = icons.kind.File,
							symlink = icons.kind.symlink,
							folder = {
								default = icons.kind.Folder,
								empty = icons.ui.EmptyFolder,
								empty_open = icons.ui.EmptyFolderOpen,
								open = icons.ui.FolderOpen,
								symlink = icons.ui.FileSymlink,
								symlink_open = "",
								arrow_open = icons.ui.ArrowDown,
								arrow_closed = icons.ui.ArrowRight,
							},
							git = {
								unstaged = "~",
                staged = icons.git.FileStaged,
								unmerged = icons.git.FileUnmerged,
								renamed = icons.git.FileRenamed,
								untracked = icons.git.FileUntracked,
								deleted = icons.git.FileDeleted,
								ignored = icons.git.FileIgnored,
							},
						},
					},
				},
				sync_root_with_cwd = false, -- Changes the tree root directory on `DirChanged` and refreshes the tree
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				view = {
					adaptive_size = false,
					centralize_selection = true,
					cursorline = true,
					-- float = {
					-- 	enable = false,
					-- 	open_win_config = function()
					-- 		local screen_w = vim.opt.columns:get()
					-- 		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					-- 		local window_w = screen_w * WIDTH_RATIO
					-- 		local window_h = screen_h * HEIGHT_RATIO
					-- 		local window_w_int = math.floor(window_w)
					-- 		local window_h_int = math.floor(window_h)
					-- 		local center_x = (screen_w - window_w) / 2
					-- 		local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					--
					-- 		return {
					-- 			border = "rounded",
					-- 			relative = "editor",
					-- 			row = center_y,
					-- 			col = center_x,
					-- 			width = window_w_int,
					-- 			height = window_h_int,
					-- 		}
					-- 	end,
					-- },
					preserve_window_proportions = true,
					-- width = function()
					--   return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					-- end,
					side = "left",
					width = 40,
				},
				ui = {
					confirm = {
						remove = true, -- Prompt before removing files
						trash = false, -- Prompt before trashing files
					},
				},
			})
		end,
		keys = {
			{
				"<leader>ee",
				"<cmd>NvimTreeToggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle file explorer" },
			},
			{
				"<leader>ef",
				"<cmd>NvimTreeFindFileToggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle file explorer on current file" },
			},
			{
				"<leader>ec",
				"<cmd>NvimTreeCollapse<CR>",
				{ noremap = true, silent = true, desc = "Collapse file explorer" },
			},
			{
				"<leader>er",
				"<cmd>NvimTreeRefresh<CR>",
				{ noremap = true, silent = true, desc = "Refresh file explorer" },
			},
		},
	},
}
