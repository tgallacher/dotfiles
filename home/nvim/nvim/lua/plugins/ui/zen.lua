return {
  { -- dim inactive code sections
    "folke/twilight.nvim",
    config = true,
    keys = {
      { "<leader>zt", ":Twilight <CR>", "n", { desc = "Toggle Twilight [Z]en [F]ocus", noremap = true, silent = true } },
    },
  },

  { -- distraction-free coding
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>zm", ":ZenMode <CR>", "n", { desc = "Toggle [Z]en [M]ode", noremap = true, silent = true } },
    },
  },
}
