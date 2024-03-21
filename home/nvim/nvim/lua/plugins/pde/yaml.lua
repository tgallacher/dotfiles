local servers = {
  yamlls = {
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        -- schemas = require("schemastore").yaml.schemas(),
        schemaStore = {
          -- you must diable built-in schemaStore support if you want to use the plugin and it's adv features
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        keyOrdering = false,
        format = { enable = true },
        validate = { enable = true },
      },
    },
  },
}

-- account for first time bootup, and the schemastore plugin hasn't been installed yet
local isOk, schemastore = pcall(require, "schemastore")
if isOk then
  servers.yamlls.settings.yaml.schemas = schemastore.yaml.schemas()
end

return {
  "b0o/SchemaStore.nvim",

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
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { yaml = { "prettierd" } } })
    end,
  },
}
