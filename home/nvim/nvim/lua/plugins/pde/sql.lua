-- FIXME: Update to nvim 0.11 setup when this LSP is required
return {
  -- TODO: move to new nvim-treesitter approach
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "sql" })
  --     return opts
  --   end,
  -- },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "sqlfluff" })
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          sql = { "sqlfluff" },
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
          sql = { "sqlfluff" },
          mysql = { "sqlfluff" },
          plsql = { "sqlfluff" },
        },
      })
    end,
  },
}
