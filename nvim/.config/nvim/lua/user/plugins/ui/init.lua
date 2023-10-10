return {
  -- core ui library used by various plugins
  "MunifTanjim/nui.nvim",

  -- filetype icons, used by many plugins
  "nvim-tree/nvim-web-devicons",

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { relative = "editor" },
      select = {
        backend = { "telescope", "fzf", "builtin" },
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      -- background_colour = "#A3CCBE",
      timeout = 5000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },

  -- dim inactive code sections
  {
    "folke/twilight.nvim",
    config = true,
    keys = {
      { "<leader>tw", ":Twilight <CR>", "n", { noremap = true, silent = true } },
    },
  },

  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>zm", ":ZenMode <CR>", "n", { noremap = true, silent = true } },
    },
  },

  -- visualise hex codes
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },
}
