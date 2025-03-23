return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "sql" })
      return opts
    end,
  },

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
      -- local linters_by_ft = { sql = {}}
      -- for _, ft in ipairs(sql_ft) do
      --   print(ft)
      --   opts.linters_by_ft[ft] = {}
      --   table.insert(linters_by_ft[ft], "sqlfluff")
      -- end
      --
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          sql = "sqlfluff",
          mysql = "sqlfluff",
          plsql = "sqlfluff",
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- local formatters_by_ft = {sql = {}}
      -- for _, ft in ipairs(sql_ft) do
      --   opts.formatters_by_ft[ft] = {}
      --   table.insert(formatters_by_ft[ft], "sqlfluff")
      -- end

      return vim.tbl_deep_extend("force", opts, {
        formatters = {
          sqlfluff = {
            args = { "format", "--dialect=ansi", "-" },
          },
        },
        formatters_by_ft = {
          sql = "sqlfluff",
          mysql = "sqlfluff",
          plsql = "sqlfluff",
        },
      })
    end,
  },
}
