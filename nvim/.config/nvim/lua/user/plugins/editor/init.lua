return {
  "nvim-lua/plenary.nvim",

  -- Peek buffer when entering line number :<number>
  { "nacro90/numb.nvim", event = "BufReadPre", config = true },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>",  mode = { "n", "v" } },
      { "<C-x>",  mode = { "n", "v" } },
      { "g<C-a>", mode = { "v" } },
      { "g<C-x>", mode = { "v" } },
    },
    -- stylua: ignore
    init = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { desc = "Decrement", noremap = true })
    end,
  },

  -- toggle comment lines/blocks, gcc or gbc etc
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      { "gc",  mode = { "v" } },
      { "gcc", mode = { "n" } },
      { "gbc", mode = { "n", "v" } },
    },
    config = function()
      local comment = require "Comment"

      comment.setup {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  {
    "max397574/better-escape.nvim",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk" },
      }
    end,
  },

  -- Easier management of buffers
  {
    "ojroques/nvim-bufdel",
    event = { "BufReadPre", "BufNewFile" },
    opts = { quit = false },
    keys = {
      { "<leader>bc", "<cmd> BufDel<cr>",       desc = "Close current buffer" },
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
    event = "VimEnter",
    init = function()
      -- Preserve zoom on Tmux navigation
      vim.g.tmux_navigator_preserve_zoom = 1
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },

  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
    enabled = false,
  },

  -- add:    ys{motion}{char}
  -- delete: ds{char}
  -- change: cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    event = "BufReadPre",
    opts = {},
  },

  -- align
  "godlygeek/tabular",

  -- TODO: add keymaps
  {
    "dnlhc/glance.nvim",
    cmd = { "Glance" },
    opts = {
      preview_win_opts = { wrap = false },
      theme = { mode = "darken" },
    },
    keys = {
      { "<localleader>gD", "<cmd>Glance definitions<cr>" },
      { "<localleader>gR", "<cmd>Glance references<cr>" },
      { "<localleader>gY", "<cmd>Glance type_definitions<cr>" },
      { "<localleader>gM", "<cmd>Glance implementations<cr>" },
    },
  },

  -- show keyboard with keys that have keymaps
  {
    "jokajak/keyseer.nvim",
    opts = {},
    version = false,
    event = "VeryLazy",
    cmd = { "KeySeer" },
  },
}
