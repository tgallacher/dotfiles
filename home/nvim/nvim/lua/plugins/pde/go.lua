vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork" },
  callback = function()
    vim.opt_local.colorcolumn = "120"
  end,
})

vim.lsp.enable({ "gopls" })

return {
  -- TODO: move to new nvim-treesitter approach
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
  --     return opts
  --   end,
  -- },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
        "gopls",
        "delve", -- debugger
        "gomodifytags", -- binary to automate Go's Struct tags (e.g. json)
        "impl", -- TODO: what is this?
        "goimports", -- formatter
        "gofumpt", -- formatter
        "gotestsum",
        "golangci-lint", -- linter
      })
      return opts
    end,
  },

  { -- DAP integration
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = {
      dap_configurations = {
        -- @see https://github.com/leoluz/nvim-dap-go?tab=readme-ov-file#debugging-with-dlv-in-headless-mode
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      -- Neotest Gingko (syntax) Adaptor
      -- see https://github.com/fredrikaverpil/neotest-golang/issues/204
      { "nvim-contrib/nvim-ginkgo" },
      -- see https://github.com/nvim-contrib/nvim-ginkgo/pull/6
      -- { "cenk1cenk2/nvim-ginkgo", commit = "5238a35b3e8b0564ff3858ae8b5783d11c03d3ab" },
      -- Neotest Adaptor
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        adapters = {
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
          require("nvim-ginkgo"),
        },
      })
    end,
  },

  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = function(_, opts)
  --     return vim.tbl_deep_extend("force", opts, {
  --       linters_by_ft = {
  --         go = { "golangcilint" },
  --       },
  --     })
  --   end,
  -- },

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
    ft = "go",
    cmd = { "GoAddTags", "GoRemoveTags", "GoInstallModifyTagsBin" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = { transform = "camelcase" },
    config = function(_, opts)
      require("gomodifytags").setup(opts)
    end,
  },

  {
    -- Acces to `impl` cli tool to stub out struct method stubs
    -- Note: requires `impl` binary (see mason)
    "rhysd/vim-go-impl",
    ft = "go",
    cmd = { "GoImpl" },
  },
}
