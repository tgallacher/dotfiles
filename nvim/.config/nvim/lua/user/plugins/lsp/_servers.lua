local M = {
  servers = {
    "lua_ls",
    -- "cssls",
    "html",
    "tsserver",
    -- "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "emmet_ls",
    "dockerls",
    "docker_compose_language_service",
    "eslint",
    "graphql",
    "rnix",
    "prismals",
    "sqlls",
    "taplo", -- toml
    "terraformls",
    "gopls",
  },
-- Language servers config override
--  Note: key must match Mason LSP server name above
  serverConfigs = {
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    },
    emmet_ls = {
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    }
  },
}


return M
