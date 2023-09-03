return {
  -- token parser
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- mainline
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    cmd = "TSUpdateSync",
    opts = {
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
        enable = true,   -- false will disable the whole extension
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
      sync_install = true, -- install languages synchronously  only applied to `ensure_installed`
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
        hijack_cursor = true,                   -- Keeps the cursor on the first letter of the filename when moving in the tree
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

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      -- { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)", },
      { "<leader>:",  "<cmd>Telescope command_history<cr>",               desc = "Command History", },
      -- { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)", },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },
      -- { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)", },
      -- { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)", },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                      desc = "Recent" },
      -- { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)", },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",                   desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",                    desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>",                     desc = "Registers", },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>",                  desc = "Auto Commands", },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",               desc = "Command History", },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                      desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",           desc = "Document diagnostics", },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                   desc = "Workspace diagnostics", },
      -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)", },
      -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)", },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages", },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",                    desc = "Search Highlight Groups", },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                       desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                     desc = "Man Pages", },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark", },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                   desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",                        desc = "Resume" },
      -- { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)", },
      -- { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)", },
      -- { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)", },
      -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)", },
      -- { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview", },
      -- {
      -- 	"<leader>ss",
      -- 	Util.telescope("lsp_document_symbols", {
      -- 		symbols = {
      -- 			"Class",
      -- 			"Function",
      -- 			"Method",
      -- 			"Constructor",
      -- 			"Interface",
      -- 			"Module",
      -- 			"Struct",
      -- 			"Trait",
      -- 			"Field",
      -- 			"Property",
      -- 		},
      -- 	}),
      -- 	desc = "Goto Symbol",
      -- },
      -- {
      -- 	"<leader>sS",
      -- 	Util.telescope("lsp_dynamic_workspace_symbols", {
      -- 		symbols = {
      -- 			"Class",
      -- 			"Function",
      -- 			"Method",
      -- 			"Constructor",
      -- 			"Interface",
      -- 			"Module",
      -- 			"Struct",
      -- 			"Trait",
      -- 			"Field",
      -- 			"Property",
      -- 		},
      -- 	}),
      -- 	desc = "Goto Symbol (Workspace)",
      -- },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
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
            -- ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            -- ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            ["<C-j>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
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
    config = function()
      local telescope = require("telescope")
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
    opts = {
      on_attach = function()
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>x", ":BufDel <CR>", opts)
        vim.keymap.set("n", "<leader>X", ":BufDelOthers <CR>", opts)
      end,
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
    opt = {
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
      numhl = true,   -- Toggle with `:Gitsigns toggle_numhl`
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
      -- TODO: review hot keys. clashes?
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                           desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",   desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      -- TODO: review hot key. Clashing with buffer management?
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
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
}
