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
      { "<leader>B", ":e#", desc = "Open last closed [B]uffer" },
    },
  },

  -- { -- autoclose html tags
  --   "windwp/nvim-ts-autotag",
  --   event = { "InsertEnter" },
  --   dependencies = { "nvim-treesitter" },
  --   opts = {
  --     filetypes = {
  --       "html",
  --       "javascript",
  --       "typescript",
  --       "javascriptreact",
  --       "typescriptreact",
  --       "svelte",
  --       "vue",
  --       "tsx",
  --       "jsx",
  --       "rescript",
  --       "xml",
  --       "php",
  --       -- "markdown",
  --       "astro",
  --       "glimmer",
  --       "handlebars",
  --       "hbs",
  --     },
  --   },
  -- },

  -- "gc<motion>" to comment visual regions/lines
  {
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
        lsp_fallback = true,
      },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- formatters_by_ft = { },
    },
  },

  { -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    "echasnovski/mini.ai",
    version = false, -- main branch
    opts = {
      n_lines = 500,
    },
  },

  -- add:    ys{motion}{char}
  -- delete: ds{char}
  -- change: cs{target}{replacement}
  {
    "kylechui/nvim-surround",
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

  -- { -- autoclose parens, brackets, quotes, etc
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   opts = {
  --     check_ts = true, -- treesitter not typescript
  --     ts_config = { -- ignore these treesitter nodes, per filetype
  --       lua = { "string", "source" },
  --       javascript = { "string", "template_string" },
  --       java = false,
  --     },
  --     disable_filetype = { "TelescopePrompt", "spectre_panel" },
  --     fast_wrap = {
  --       cursor_pos_before = false,
  --       map = "<M-e>",
  --       chars = { "{", "[", "(", '"', "'" },
  --       pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
  --       offset = 0, -- Offset from pattern match
  --       end_key = "$",
  --       keys = "qwertyuiopzxcvbnmasdfghjkl",
  --       check_comma = true,
  --       highlight = "PmenuSel",
  --       highlight_grey = "LineNr",
  --     },
  --   },
  --   config = function(_, opts)
  --     local autopairs = require("nvim-autopairs")
  --     autopairs.setup(opts)
  --
  --     -- insert `(` after select function or method item
  --     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --     local cmp = require("cmp")
  --     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --   end,
  -- },

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
      vim.keymap.set("n", "<leader>ht", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "[H]arpoon [T]oggle File Menu" })

      vim.keymap.set("n", "<leader>hy", function() harpoon:list():select(1) end, {desc = "Open Harpoon File 1" })
      vim.keymap.set("n", "<leader>hu", function() harpoon:list():select(2) end, {desc = "Open Harpoon File 2" })
      vim.keymap.set("n", "<leader>hi", function() harpoon:list():select(3) end, {desc = "Open Harpoon File 3" })
      vim.keymap.set("n", "<leader>ho", function() harpoon:list():select(4) end, {desc = "Open Harpoon File 4" })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():select(5) end, {desc = "Open Harpoon File 5" })

      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, {desc = "Harpoon jump to PREV buffer" })
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, {desc = "Harpoon jump to NEXT buffer" })
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
    },
  },

  { "mfussenegger/nvim-dap" },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
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
  --   "wolffiex/shellbot",
  --   -- name = "chatgpt",
  --   config = function()
  --     -- Alternative: thmsmlr/gpt.nvim
  --     --
  --     -- ==Manual SETUP instructions
  --     --
  --     -- 1. Set OPENAI_API_KEY shell variable
  --     -- 2. run `cargo build --release` inside nix-shell within the lazy folder for the plugin
  --     --
  --     -- /end
  --
  --     -- ==INSTALL
  --     -- source: https://github.com/wincent/wincent/blob/main/aspects/nvim/files/.config/nvim/after/plugin/shellbot.lua
  --     vim.api.nvim_create_user_command("ChatGPT", function()
  --       local has_shellbot, shellbot = pcall(require, "shellbot")
  --       if not has_shellbot then
  --         vim.api.nvim_err_writeln("error: could not require 'chatgpt'; is the submodule initialized?")
  --         return
  --       end
  --       if vim.env["SHELLBOT"] == nil or vim.fn.executable(vim.env["SHELLBOT"]) ~= 1 then
  --         vim.api.nvim_err_writeln("error: SHELLBOT does not appear to be executable")
  --         return
  --       end
  --       shellbot.chatgpt()
  --     end, {})
  --
  --     local opts = { silent = true, noremap = true }
  --
  --     -- ==SET UP KEYBINDS
  --     opts.desc = "ChatGPT"
  --     vim.keymap.set("n", "<C-g>", ":ChatGPT<CR>", opts)
  --   end,
  -- },

  -- {
  --   "dhruvasagar/vim-table-mode",
  -- },
}
