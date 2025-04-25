vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = false

    vim.opt_local.colorcolumn = "120"
  end,
})

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
      opts.ensure_installed = vim.list_extend(
        opts.ensure_installed,
        vim.list_extend(vim.tbl_keys(servers), {
          "delve", -- debugger
          "gomodifytags", -- binary to automate Go's Struct tags (e.g. json)
          "impl",
          "goimports", -- formatter
          "gofumpt", -- formatter
          "gotestsum",
          "golines", -- formatter
        })
      )
      return opts
    end,
  },

  { -- DAP integration
    "leoluz/nvim-dap-go",
    opts = {},
    config = function()
      require("dap-go").setup()
    end,
  },

  { -- Neotest Adaptor
    "fredrikaverpil/neotest-golang",
    version = "*",
  },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        adapters = {
          require("neotest-golang")({
            runner = "gotestsum", -- better json parsing for Neotest attach, etc
            dap_go_enabled = false, -- requires "leoluz/nvim-dap-go"
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out", -- requires "andythigpen/nvim-coverage" to display in neovim
            },
            gotestsum_args = { "--format=standard-verbose" },
          }),
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
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          go = { "goimports", "gofumpt", "golines" },
        },
      })
    end,
  },

  { -- Automate adding Go tags to structs (e.g `json`)
    "zgs225/gomodifytags.nvim",
    cmd = { "GoAddTags", "GoRemoveTags", "GoInstallModifyTagsBin" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      transform = "camelcase",
    },
    config = function(_, opts)
      require("gomodifytags").setup(opts)
    end,
  },
}
