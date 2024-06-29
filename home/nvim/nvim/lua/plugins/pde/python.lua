local servers = {
  djlint = {
    settings = {
      indent = 4,
      max_line_length = 120,
    },
  },
  pyright = {
    settings = {
      filetypes = { "python" },
      typeCheckingMode = "off", -- use mypy instead
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "python", "htmldjango" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(
        opts.ensure_installed,
        vim.list_extend(vim.tbl_keys(servers), {
          "ruff",
          "mypy",
          "black",
          "debugpy",
        })
      )
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          python = { "mypy", "ruff" },
        },
      })
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
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          j2 = { "djlint" },
          python = { "black" },
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

      require("dap-python").setup(path)

      vim.keymap.set("n", "<localleader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<localleader>dr", function()
        require("dap-python").test_method()
      end, { desc = "Toggle breakpoint" })
    end,
  },
}
