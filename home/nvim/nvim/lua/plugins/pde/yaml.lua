vim.lsp.enable({ "yamlls" })

-- account for first time bootup, and the schemastore plugin hasn't been installed yet
local isOk, schemastore = pcall(require, "schemastore")
if isOk then
  vim.lsp.yamlls.settings.yaml.schemas = schemastore.yaml.schemas()
end

return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "yaml" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "yamlls", "prettierd" })
      return opts
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { yaml = { "prettierd" } } })
    end,
  },
}
