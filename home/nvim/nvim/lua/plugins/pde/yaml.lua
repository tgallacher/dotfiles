-- FIXME: Update to nvim 0.11 setup when this LSP is required
local servers = {
  yamlls = {
    -- Have to add this for yamlls to understand that we support line folding
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas = vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = { enable = true },
        validate = true,
        schemaStore = {
          -- Must disable built-in schemaStore support to use
          -- schemas from SchemaStore.nvim plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
      },
    },
  },
}

-- account for first time bootup, and the schemastore plugin hasn't been installed yet
local isOk, schemastore = pcall(require, "schemastore")
if isOk then
  servers.yamlls.settings.yaml.schemas = schemastore.yaml.schemas()
end

return {} -- tmp disable
-- return {
--   {
--     "b0o/SchemaStore.nvim",
--     lazy = true,
--     version = false, -- last release is way too old
--   },
--
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "yaml" })
--       return opts
--     end,
--   },
--
--   {
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "prettierd" }))
--       return opts
--     end,
--   },
--
--   { -- Autoformat
--     "stevearc/conform.nvim",
--     opts = function(_, opts)
--       return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { yaml = { "prettierd" } } })
--     end,
--   },
-- }
