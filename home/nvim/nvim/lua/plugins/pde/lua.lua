-- FIXME: Update to nvim 0.11 setup when this LSP is required
vim.lsp.enable({ "lua-language-server" })

return {
  { -- ?
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { --  cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    enabled = false,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "lua-language-server", "stylua" })
      return opts
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { lua = { "stylua" } } })
    end,
  },

  {
    "jbyuki/one-small-step-for-vimkind",
    config = function()
      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      vim.keymap.set("n", "<leader>dl", function()
        require("osv").launch({ port = 8086 })
      end, { noremap = true })

      vim.keymap.set("n", "<leader>dw", function()
        local widgets = require("dap.ui.widgets")
        widgets.hover()
      end)

      vim.keymap.set("n", "<leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set("n", "<leader>dl", function()
        require("osv").launch({ port = 8086 })
      end, { noremap = true })

      vim.keymap.set("n", "<leader>dw", function()
        local widgets = require("dap.ui.widgets")
        widgets.hover()
      end)

      vim.keymap.set("n", "<leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end)
    end,
  },
}
