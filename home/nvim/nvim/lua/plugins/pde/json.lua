local servers = {
  jsonls = {
    settings = {
      json = {
        -- FIXME: causing errors on every edit to the file
        -- lazy-load schemastore when needed
        -- on_new_config = function(new_config)
        --   new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        --   vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        -- end,
        format = { enable = true },
        validate = { enable = true },
      },
    },
  },
}
-- account for first time bootup, and the schemastore plugin hasn't been installed yet
local isOk, schemastore = pcall(require, "schemastore")
if isOk then
  servers.jsonls.settings.json.schemas = schemastore.json.schemas()
end

return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release too old
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "json", "json5", "jsonc" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "prettierd" }))
      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { servers = servers })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { json = { "prettierd" } } })
    end,
  },
}
