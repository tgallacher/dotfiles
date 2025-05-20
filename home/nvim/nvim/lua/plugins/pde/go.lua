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
    cmd_env = {
      -- Limit line length; similar to `golines` formatter
      GOFUMPT_SPLIT_LONG_LINES = "on", -- defaults to 100 columns / runes
    },
    settings = {
      gopls = {
        gofumpt = true, -- use gofumt instead of gofmt; gofumpt is a superset of gofmpt with stricter rules
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
          "impl", -- what is this?
          "goimports", -- formatter
          "gofumpt", -- formatter
          "gotestsum",
          -- "golines", -- formatter (shorten line length)
          "golangci-lint", -- linter
        })
      )
      return opts
    end,
  },

  { -- DAP integration
    "leoluz/nvim-dap-go",
    opts = {},
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      -- see https://github.com/fredrikaverpil/neotest-golang/issues/204
      { "nvim-contrib/nvim-ginkgo", commit = "5238a35b3e8b0564ff3858ae8b5783d11c03d3ab" }, -- Gingko syntax support
      -- Neotest Adaptor
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        adapters = {
          require("nvim-ginkgo"),
          require("neotest-golang")({
            runner = "gotestsum", -- better json parsing for Neotest attach, etc
            dap_go_enabled = true, -- requires "leoluz/nvim-dap-go"
            gotestsum_args = { "--format=standard-verbose" },
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out", -- requires "andythigpen/nvim-coverage" to display in neovim
            },
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

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          go = { "golangcilint" },
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
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
    opts = { transform = "camelcase" },
    config = function(_, opts)
      require("gomodifytags").setup(opts)
    end,
  },
}
