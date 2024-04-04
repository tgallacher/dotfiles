return {
  { -- supercharge substitution from copy buffer
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local substitute = require("substitute")

      substitute.setup()

      vim.keymap.set("n", "s", substitute.operator, { desc = "[S]ubstitute with motion" })
      vim.keymap.set("n", "ss", substitute.line, { desc = "[S]ubstitute [S]ingle line" })
      vim.keymap.set("n", "S", substitute.eol, { desc = "[S]ubstitute to end of line" })
      vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
    end,
  },
}
