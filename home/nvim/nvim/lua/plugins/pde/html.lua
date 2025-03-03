local servers = {
  cssls = {},
  html = {
    filetypes = { "html", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  },
  -- https://github.com/emmetio/emmet
  emmet_ls = {
    filetypes = { "html", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = { ["bem.enabled"] = true },
      },
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "html", "css" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "prettierd", "html-lsp", "emmet-ls" }))
      return opts
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
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = {
        html = { "prettierd" },
        css = { "prettierd" },
      } })
    end,
  },
}
