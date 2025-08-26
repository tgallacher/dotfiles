-- vim.lsp.enable("ts_ls")
vim.lsp.enable("vtsls")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript" },
  callback = function()
    vim.treesitter.start()
  end,
})

require("nvim-treesitter").install({ "javascript", "typescript", "tsx", "jsdoc" })

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "prettierd", -- formatter
        "eslint_d", -- linter
        "biome", -- linter
        "js-debug-adapter", -- dap
        -- "ts_ls", -- lsp
        "vtsls", -- lsp
      })

      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      vim.env.ESLINT_D_PPID = vim.fn.getpid() -- which parent process to monitor; kill deamon if this closes
      vim.env.ESLINT_D_MISS = "ignore" -- how to behave if local eslint is missing
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          typescript = { "biomejs", "eslint_d" },
          javascript = { "biomejs", "eslint_d" },
          -- typescriptreact = { "eslint" },
          -- javascriptreact = { "eslint" },
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", {
        formatters_by_ft = {
          javascript = { "biome-check", "prettier", stop_after_first = true },
          typescript = { "biome-check", "prettier", stop_after_first = true },
        },
      }, opts)
    end,
  },
}
