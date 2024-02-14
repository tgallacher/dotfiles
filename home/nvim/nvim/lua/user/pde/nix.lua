if not require("user.config.pde").lsp.nix then return {} end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rnix = {},
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "nix" }) end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "rnix-lsp" }) end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      table.insert(opts.sources, nls.builtins.formatting.alejandra)
    end,
  },
}
