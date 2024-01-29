if not require("user.config.pde").lsp.lua then return {} end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "stylua" }) end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.stylua)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        -- opts = {
        --   library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
        -- },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.stdpath "config" .. "/lua"] = true,
                },
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = { enable = false },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, _)
          -- local lsp_utils = require "plugins.lsp.utils"

          -- lsp_utils.on_attach(function(client, buffer)
          --   -- stylua: ignore
          --   if client.name == "lua_ls" then
          --     vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end, { buffer = buffer, desc = "OSV Run" })
          --     vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end, { buffer = buffer, desc = "OSV Launch" })
          --   end
          -- end)
        end,
      },
    },
  },
}
