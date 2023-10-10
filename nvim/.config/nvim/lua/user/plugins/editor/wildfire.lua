return {
  -- Better in/around incremental token selection
  -- <CR> - select text object; keep hitting to go up tree
  -- <BS> - undo selection done by above
  "sustech-data/wildfire.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
}
