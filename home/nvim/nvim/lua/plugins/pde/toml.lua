vim.lsp.enable({ "tombi" })

require("nvim-treesitter").install({ "toml" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "toml" },
  callback = function()
    vim.treesitter.start()
  end,
})

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "taplo", "tombi" })
      return opts
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { toml = { "tombi" } } })
    end,
  },
}
