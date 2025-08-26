vim.lsp.enable({ "bashls" })

return {
  -- TODO: move to new nvim-treesitter approach
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "bash" })
  --     return opts
  --   end,
  -- },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "shfmt",
        "shellcheck",
      })
      return opts
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          sh = { "shfmt" },
        },
      })
    end,
  },
}
