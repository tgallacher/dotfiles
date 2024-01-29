return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<A-d>]] },
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
    direction = "float",
    winbar = { enabled = false },
  },
}
