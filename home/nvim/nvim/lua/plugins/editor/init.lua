return {
  { -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  { -- Easier management of buffers
    "ojroques/nvim-bufdel",
    event = { "BufReadPre", "BufNewFile" },
    opts = { quit = false },
    keys = {
      { "<leader>bc", "<cmd> BufDel<cr>", desc = "Close current buffer" },
      { "<leader>bC", "<cmd> BufDelOthers<cr>", desc = "Close all other buffers" },
      { "<leader>B", ":e#<cr>", desc = "Open last closed [B]uffer" },
    },
  },

  { -- "gc<motion>" to comment visual regions/lines
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      --- @diagnostic disable-next-line: missing-fields
      comment.setup({
        -- commenting tsx, jsx, html, etc
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = "fallback",
      },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- formatters_by_ft = { },
    },
    -- init = function()
    --   require("").formatters.prettierd = {}
    -- end,
  },

  { -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - vab  - [V]isually select [A]round [b]rackets
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = false, -- main branch, recommended
    -- source: https://www.lazyvim.org/plugins/coding
    opts = function()
      local ai = require("mini.ai")

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      --   LazyVim.on_load("which-key.nvim", function()
      --     vim.schedule(function()
      --       LazyVim.mini.ai_whichkey(opts)
      --     end)
      --   end)
    end,
  },

  -- add:    ys{motion}{char}
  -- delete: ds{char}
  -- change: cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      delay = 200,
      providers = { "lsp", "treesitter" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "ThePrimeagen/harpoon",
    -- enabled = false,
    branch = "harpoon2",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")

      harpoon:setup(opts)

      --stylua: ignore start
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "[H]arpoon [A]dd File" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "[H]arpoon [T]oggle File Menu" })

      vim.keymap.set("n", "<leader>ht", function() harpoon:list():select(1) end, {desc = "Open Harpoon File 1" })
      vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(2) end, {desc = "Open Harpoon File 2" })
      vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end, {desc = "Open Harpoon File 3" })
      vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(4) end, {desc = "Open Harpoon File 4" })
      vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(5) end, {desc = "Open Harpoon File 5" })

      vim.keymap.set("n", "<C-m>", function() harpoon:list():prev() end, {desc = "Harpoon jump to PREV buffer" })
      vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, {desc = "Harpoon jump to NEXT buffer" })
      --stylua: ignore end
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    keys = {
      { "<leader>tq", ":TodoQuickFix<CR>", desc = "Open [T]rouble [Q]uickfix List" },
      { "<leader>tl", ":TodoLocList<CR>", desc = "Open [T]rouble [L]ocation List" },
      { "<leader>tt", ":TodoTelescope<CR>", desc = "Open todos in trouble" },
      { "<leader>tb", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "[T]rouble [b]uffer" },
    },
  },

  -- { -- Copy files to/from remote machine within nvim
  --   "OscarCreator/rsync.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   enabled = false,
  --   build = "make",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   opts = {
  --     project_config_path = "rysnc-nvim.toml",
  --   },
  --   -- config = function()
  --   --   require("rsync").setup()
  --   -- end,
  -- },

  -- {
  --   "dhruvasagar/vim-table-mode",
  -- },
  --

  {
    "Vigemus/iron.nvim",
    opts = function()
      -- local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      return {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "bash", "-c" },
            },
            python = {
              command = { "python3" }, -- or { "ipython", "--no-autoindent" }
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
            },
            lua = {
              command = { "lua" },
            },
          },
          -- set the file type of the newly created repl to ft
          -- bufnr is the buffer id of the REPL and ft is the filetype of the
          -- language being used for the REPL.
          repl_filetype = function(_, ft)
            return ft
            -- or return a string name such as the following
            -- return "iron"
          end,
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = view.bottom("40%"),

          -- repl_open_cmd can also be an array-style table so that multiple
          -- repl_open_commands can be given.
          -- When repl_open_cmd is given as a table, the first command given will
          -- be the command that `IronRepl` initially toggles.
          -- Moreover, when repl_open_cmd is a table, each key will automatically
          -- be available as a keymap (see `keymaps` below) with the names
          -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
          -- For example,
          --
          -- repl_open_cmd = {
          --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
          --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
          -- }
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          toggle_repl = "<localleader>rr", -- toggles the repl open and closed.
          -- If repl_open_command is a table as above, then the following keymaps are
          -- available
          -- toggle_repl_with_cmd_1 = "<space>rv",
          -- toggle_repl_with_cmd_2 = "<space>rh",
          restart_repl = "<localleader>rR", -- calls `IronRestart` to restart the repl
          send_motion = "<localleader>rc",
          visual_send = "<localleader>rc",
          send_file = "<localleader>rf",
          send_line = "<localleader>rl",
          send_paragraph = "<localleader>rp",
          send_until_cursor = "<localleader>ru",
          send_mark = "<localleader>rm",
          send_code_block = "<localleader>rb",
          send_code_block_and_move = "<localleader>rn",
          mark_motion = "<localleader>mc",
          mark_visual = "<localleader>mc",
          remove_mark = "<localleader>md",
          cr = "<localleader>s<cr>",
          interrupt = "<localleader>s<localleader>",
          exit = "<localleader>rq",
          clear = "<localleader>rd",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }
    end,
  },
}
