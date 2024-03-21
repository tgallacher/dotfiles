return {
  { -- dim inactive code sections
    "folke/twilight.nvim",
    config = true,
    keys = {
      { "<leader>tw", ":Twilight <CR>", "n", { noremap = true, silent = true } },
    },
  },

  { -- distraction-free coding
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>zm", ":ZenMode <CR>", "n", { noremap = true, silent = true } },
    },
  },
}
