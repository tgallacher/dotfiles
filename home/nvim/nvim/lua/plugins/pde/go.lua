local servers = {
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "delve", "gomodifytags", "impl", "goimports", "gofumpt" }))
      return opts
    end,
  },

  {
    "leoluz/nvim-dap-go",
    opts = {},
  },

  { "fredrikaverpil/neotest-golang" },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        adapters = {
          ["neotest-golang"] = {
            -- Here we can set options for neotest-golang, e.g.
            -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
            dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        servers = servers,
        -- setup = {
        --   gopls = function()
        --     -- workaround for gopls not supporting semanticTokensProvider
        --     -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        --     LazyVim.lsp.on_attach(function(client, _)
        --       if not client.server_capabilities.semanticTokensProvider then
        --         local semantic = client.config.capabilities.textDocument.semanticTokens
        --         client.server_capabilities.semanticTokensProvider = {
        --           full = true,
        --           legend = {
        --             tokenTypes = semantic.tokenTypes,
        --             tokenModifiers = semantic.tokenModifiers,
        --           },
        --           range = true,
        --         }
        --       end
        --     end, "gopls")
        --     -- end workaround
        --   end,
        -- },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { go = { "goimports", "gofumpt" } } })
    end,
  },
}
