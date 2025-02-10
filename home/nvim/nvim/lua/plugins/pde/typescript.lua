local servers = {
  ts_ls = {},
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "graphql",
        "prisma",
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "prettierd", -- formatter
        -- { "eslint_d", version = "14.3.0" }, -- linter
        "eslint",
        "js-debug-adapter", -- dap
        "typescript-language-server", -- lsp
      })
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      vim.env.ESLINT_D_PPID = vim.fn.getpid()
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          -- typescript = { "eslint" },
          -- javascript = { "eslint" },
          -- typescriptreact = { "eslint" },
          -- javascriptreact = { "eslint" },
        },
      })
    end,
  },

  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "neovim/nvim-lspconfig",
  --   },
  --   opts = {},
  --   ft = {
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --   },
  -- },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", {
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
        },
      }, opts)
    end,
  },
}
