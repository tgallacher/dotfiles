if not require("user.config.pde").lsp.yaml then return {} end

-- TODO: Add config
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {},
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, {}) end,
  },
}
