-- FIXME: Update to nvim 0.11 setup when this LSP is required
return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "dockerfile" })
  --     return opts
  --   end,
  -- },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint", -- linter
      })
      return opts
    end,
  },
}
