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
      search = {
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--ignore-case", -- doesn't work
        },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
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
