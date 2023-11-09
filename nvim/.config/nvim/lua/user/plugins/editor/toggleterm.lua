return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<A-d>]] },
    { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
  },
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = 40,
    hide_numbers = true,
    open_mapping = [[<A-d>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    winbar = { enabled = false },
  },
}
