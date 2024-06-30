return {
  { -- Toggle maximising split window
    "szw/vim-maximizer",
    event = "InsertEnter",
    keys = {
      { "<leader>sm", ":MaximizerToggle<cr>", { desc = "[S]plit [M]aximise window toggle" } },
    },
  },

  -- Peek buffer when entering line number :<number>
  {
    "nacro90/numb.nvim",
    event = "InsertEnter",
    config = true,
  },

  { -- visualise hex codes
    "norcalli/nvim-colorizer.lua",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "InsertEnter",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- TODO: This is a todo

  -- TODO(scope): This is a todo

  -- TODO (scope): This is a todo

  -- TODO(): This is a todo

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = { "BufNewFile", "BufReadPre" },
    priority = 0,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      -- highlight = {
      --   pattern = [[\<(KEYWORDS)\s\?(\([-\s[:alnum:]_]*\))\?:]], -- FIXME: Not working; getting E55 unmatch \) when run in cmd mode
      -- },
      search = {
        --   args = {
        --     "--color=never",
        --     "--no-heading",
        --     "--with-filename",
        --     "--line-number",
        --     "--column",
        --     "--ignore-case", -- FIXME: doesn't work
        --   },
        pattern = [[\b(KEYWORDS)\s*?(\([-\s[:alnum:]_]+\))?:]],
      },
    },
    config = function(_, opts)
      local todo_comments = require("todo-comments")

      -- stylua: ignore start
      vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next [T]odo comment" })
      vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Prev [T]odo comment" })
      -- stylua: ignore end

      todo_comments.setup(opts)
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    -- prevent https://github.com/folke/todo-comments.nvim/issues/133
    event = "VimEnter",
    config = function() -- This is the function that runs, AFTER loading
      local whichkey = require("which-key")

      whichkey.setup()

      -- Document existing key chains
      whichkey.register({
        ["<leader>f"] = { name = "[f]ind", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[w]orkspace", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "[t]rouble", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "[h]unk", _ = "which_key_ignore" },
        ["<leader>e"] = { name = "NvimTre[e]", _ = "which_key_ignore" },
        ["<leader>b"] = { name = "[b]uffers", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[s]plits", _ = "which_key_ignore" },
        ["<localleader>q"] = { name = "[q]uickfix", _ = "which_key_ignore" },
        ["<localleader>d"] = { name = "[d]iagnostic", _ = "which_key_ignore" },
      })

      -- this is to fix bug: https://github.com/folke/which-key.nvim/issues/476
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Fix which-key trigger on `localleader`",
        group = vim.api.nvim_create_augroup("whickey_localleader", { clear = true }),
        pattern = "*",
        callback = function()
          -- stylua: ignore
          -- WARN: magic string here for `localleader`; how to make this dynamic
          vim.keymap.set("n", "<localleader>", function() whichkey.show("\\") end, { buffer = true })
        end,
      })
    end,
  },

  { -- improve some vim ui elements
    "stevearc/dressing.nvim",
    -- prevent https://github.com/folke/todo-comments.nvim/issues/133
    event = "VimEnter",
    opts = {
      input = {
        -- relative = "editor",
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<C-k>"] = "HistoryPrev",
            ["<C-j>"] = "HistoryNext",
          },
        },
      },
    },
  },

  {
    "j-hui/fidget.nvim",
    -- tag = "legacy",
    event = { "BufEnter" },
    opts = {
      notification = {
        window = {
          winblend = 0, -- drop background
        },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {},
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      --- @diagnostic disable: unused-local
      require("ufo").setup({
        provider_selector = function(_bufnr, _filetype, _buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
