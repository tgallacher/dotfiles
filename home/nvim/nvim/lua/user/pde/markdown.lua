if not require("user.config.pde").lsp.markdown then return {} end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "marksman" }) end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown tools
  --
  -- Keymaps deault
  -- zr: reduces fold level throughout the buffer
  -- zR: opens all folds
  -- zm: increases fold level throughout the buffer
  -- zM: folds everything all the way
  -- za: open a fold your cursor is on
  -- zA: open a fold your cursor is on recursively
  -- zc: close a fold your cursor is on
  -- zC: close a fold your cursor is on recursively
  { "preservim/vim-markdown", ft = { "markdown" } },

  { "mzlogin/vim-markdown-toc", ft = { "markdown" } },

  {
    "iamcco/markdown-preview.nvim",
    main = "markdown-preview",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
    },
  },
}
