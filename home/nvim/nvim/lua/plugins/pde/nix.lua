vim.lsp.enable({ "nil_ls" })

require("nvim-treesitter").install({ "nix" })

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "nil" })
      return opts
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- NOTE: need to install nixfmt using brew; Mason version not supported on OSX
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { nix = { "nixfmt" } } })
    end,
  },
}
