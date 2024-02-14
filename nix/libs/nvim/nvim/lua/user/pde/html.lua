if not require("user.config.pde").lsp.html then return {} end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        },
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
              },
            },
          },
        },
        cssls = {},
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "html", "css" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "prettierd", "html-lsp", "emmet-ls" }) end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },
}
