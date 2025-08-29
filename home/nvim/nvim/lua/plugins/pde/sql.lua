-- vim.lsp.enable({ "sqls" })
require("nvim-treesitter").install({ "sql" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function()
    vim.treesitter.start()
  end,
})

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "sqlfluff", "sqruff" })
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          sql = { "sqruff" },
          mysql = { "sqlfluff" },
          plsql = { "sqlfluff" },
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters = {
          sqlfluff = {
            args = { "format", "--dialect=ansi", "-" },
          },
        },
        formatters_by_ft = {
          sql = { "sqruff" },
          mysql = { "sqlfluff" },
          plsql = { "sqlfluff" },
        },
      })
    end,
  },
}
