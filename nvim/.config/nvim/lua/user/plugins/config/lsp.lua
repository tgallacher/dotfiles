local M = {
  servers = {
    -- "lua_ls",
    -- "cssls",
    -- "html",
    -- "tsserver",
    -- "pyright",
    -- "bashls",
    -- "jsonls",
    -- "yamlls",
    -- "emmet_ls",
    -- "dockerls",
    -- "docker_compose_language_service",
    -- "eslint",
    "graphql",
    "rnix",
    "prismals",
    "sqlls",
    -- "taplo", -- toml
    -- "terraformls",
    -- "tflint",
    -- "gopls",
  },
  -- Language servers config override
  --  Note: key must match Mason LSP server name above
  serverConfigs = {},
}

return M
