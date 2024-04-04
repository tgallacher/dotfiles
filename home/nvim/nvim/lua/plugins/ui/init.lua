return {
  { -- Toggle maximising split window
    "szw/vim-maximizer",
    event = "InsertEnter",
    keys = {
      { "<leader>sm", ":MaximizerToggle<cr>", { desc = "[S]plit [M]aximise window toggle" } },
    },
  },

  -- Peek buffer when entering line number :<number>
  { "nacro90/numb.nvim", event = "InsertEnter", config = true },

  { -- visualise hex codes
    "norcalli/nvim-colorizer.lua",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "InsertEnter",
    config = function()
      require("colorizer").setup()
    end,
  },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      -- search = {
      --   args = {
      --     "--color=never",
      --     "--no-heading",
      --     "--with-filename",
      --     "--line-number",
      --     "--column",
      --     "--ignore-case", -- FIXME: doesn't work
      --   },
      -- },
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
    event = "VeryLazy",
    config = function() -- This is the function that runs, AFTER loading
      local whichkey = require("which-key")

      whichkey.setup()

      -- Document existing key chains
      require("which-key").register({
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

      })
    end,
  },

  { -- improve some vim ui elements
    "stevearc/dressing.nvim",
    event = "VeryLazy",
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
