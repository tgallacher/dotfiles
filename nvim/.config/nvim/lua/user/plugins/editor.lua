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
			auto_install = true,
		},
	},

	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		dversion = "*",
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
					-- TODO: reuse/import git signs
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
				filters = {
					dotfiles = false, -- Do not show dotfiles (toggle with `H`)
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
							default = "",
							-- default = "󰈚",
							symlink = "",
							folder = {
								default = "",
								empty = "",
								empty_open = "",
								open = "",
								symlink = "",
								symlink_open = "",
								arrow_open = "",
								arrow_closed = "",
							},
							git = {
								unstaged = "~",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "U",
								deleted = "-",
								ignored = "◌",
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

	-- manage lists
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
    -- stylua: ignore
    keys = {
      -- { "<leader>", function() require("telescope.builtin") end, desc="" },
      -- FIXME: seems to ignore dot files/folders...
      {
        "<leader>sr",
        function() require("telescope.builtin").resume() end,
        desc = "Resume previous telescope w/state"
      },
      {
        "<leader>st",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find string (root dir)"
      },
      {
        "<leader>sT",
        function() require("telescope.builtin").live_grep({ grep_open_files = true }) end,
        desc = "Find string (open buffers)"
      },
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find files"
      },
      {
        "<leader>fF",
        function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
        desc = "Find files (hidden,ignored)"
      },
      {
        "<leader>fs",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Find string inside current buffer"
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").git_files({
            show_untracked = true,
            recurse_submodules = true
          })
        end,
        desc = "Find git files"
      },
      {
        "<leader>gc",
        function() require("telescope.builtin").git_bcommits() end,
        desc = "Show git commits for current buffer"
      },
      {
        "<leader>gs",
        function() require("telescope.builtin").git_status() end,
        desc = "Show git status for current buffer"
      },
      {
        "<leader>fr",
        function() require("telescope.builtin").oldfiles() end,
        desc = "Show recently opened files"
      },
      {
        "<leader>sh",
        function() require("telescope.builtin").search_history() end,
        desc = "Show search history"
      },
      {
        "<leader>,",
        function() require("telescope.builtin").buffers({ ignore_current_buffer = true, sort_mru = true }) end,
        desc = "Show open buffers"
      },
      {
        "<leader>th",
        function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
        desc = "Show available colorschemes"
      },
      {
        "<leader>sp",
        function() require("telescope.builtin").spell_suggest() end,
        desc = "Show spelling suggestions for word under cursor"
      },
      {
        "<a-r>",
        function() require("telescope.builtin").treesitter() end,
        desc = "Show symbols in buffer"
      },
      {
        "<leader>sd",
        function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
        desc = "Document diagnostics",
      },
      {
        "<leader>sD",
        function() require("telescope.builtin").diagnostics() end,
        desc = "Workspace diagnostics",
      },
      {
        "<leader>sw",
        function() require("telescope.builtin").grep_string() end,
        mode = "v",
        desc = "Selection (root dir)",
      },
      -- {
      --   "<leader>sW",
      --   "<cmd>Telescope grep_string cwd=false<cr>",
      --   mode = "v",
      --   desc = "Selection (cwd)",
      -- },
      {
        "<leader>bs",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol",
      },
      -- -- {
      -- -- 	"<leader>sS",
      -- -- 	Util.telescope("lsp_dynamic_workspace_symbols", {
      -- -- 		symbols = {
      -- -- 			"Class",
      -- -- 			"Function",
      -- -- 			"Method",
      -- -- 			"Constructor",
      -- -- 			"Interface",
      -- -- 			"Module",
      -- -- 			"Struct",
      -- -- 			"Trait",
      -- -- 			"Field",
      -- -- 			"Property",
      -- -- 		},
      -- -- 	}),
      -- -- 	desc = "Goto Symbol (Workspace)",
      -- -- },
    },
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				file_ignore_patterns = { "node_modules" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				mappings = {
					i = {
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<a-t>"] = function(...)
							return require("trouble.providers.telescope").open_selected_with_trouble(...)
						end,
						-- ["<a-i>"] = function()
						--   local action_state = require("telescope.actions.state")
						--   local line = action_state.get_current_line()
						--   Util.telescope("find_files", { no_ignore = true, default_text = line })()
						-- end,
						-- ["<a-h>"] = function()
						--   local action_state = require("telescope.actions.state")
						--   local line = action_state.get_current_line()
						--   Util.telescope("find_files", { hidden = true, default_text = line })()
						-- end,
						["<C-k>"] = function(...)
							return require("telescope.actions").move_selection_previous(...)
						end,
						["<C-j>"] = function(...)
							return require("telescope.actions").move_selection_next(...)
						end,
						["<C-f>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
						["<C-b>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key",
					},
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")

			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},

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

	-- autoclose parens, brackets, quotes, etc
	-- TODO: copy config to CMP: https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},

	-- git visuals / actions
	{
		"lewis6991/gitsigns.nvim",
		main = "gitsigns",
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>gbt", gs.toggle_current_line_blame)
			end,
			signs = {
				-- add = { hl = "GitSignsAdd", text = " ", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				-- change = { hl = "GitSignsChange", text = " ", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
				-- delete = { hl = "GitSignsDelete", text = " ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				-- topdelete = { hl = "GitSignsDelete", text = "󱅁 ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				-- changedelete = { hl = "GitSignsChange", text = "󰍷 ", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
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

	-- Automatically highlights other instances of the word under your cursor.
	-- This works with LSP, Treesitter, and regexp matching to find the other
	-- instances.
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
		},
		config = function(_, opts)
			local illuminate = require("illuminate")

			illuminate.configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					illuminate["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	{ "lukas-reineke/indent-blankline.nvim" },

	-- Finds and lists all of the TODO, HACK, BUG, etc comment
	-- in your project and loads them into a browsable list.
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>tT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			-- TODO: review hot key. Clashing with buffer management?
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
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

  -- align
	"godlygeek/tabular",
  
  -- Markdown tools
  -- Keymaps deault
  -- zr: reduces fold level throughout the buffer
  -- zR: opens all folds
  -- zm: increases fold level throughout the buffer
  -- zM: folds everything all the way
  -- za: open a fold your cursor is on
  -- zA: open a fold your cursor is on recursively
  -- zc: close a fold your cursor is on
  -- zC: close a fold your cursor is on recursively
	{
    "preservim/vim-markdown",
		-- event = { "BufReadPost", "BufNewFile" },
    ft = {"markdown"}
  },
  
  {
    "mzlogin/vim-markdown-toc",
		-- event = { "BufReadPost", "BufNewFile" },
    ft = {"markdown"}
  },

  {
    "iamcco/markdown-preview.nvim",
    main = "markdown-preview",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    keys = {
      { "<leader>mp",  "<cmd>MarkdownPreviewToggle<cr>", desc="Toggle markdown preview" }
    }
  }
}
