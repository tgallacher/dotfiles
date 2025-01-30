return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      linters_by_ft = {}, -- added in individual PDE files
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    },
    config = function(_, opts)
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

      -- stylua: ignore
      vim.keymap.set("n", "<localleader>ll", function() lint.try_lint() end, { desc = "Trigger [l]inting for current file" })
    end,
  },
}
