local servers = {
  -- WARNING: Large files may experience slow perf
  -- see: https://github.com/oxalica/nil/issues/83
  -- note: this may have been fixed in nvim 0.9.1+
  nil_ls = {
    filetypes = { "nix" },
    settings = {},
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "nix" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), {}))
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
      -- note: `alejandra` installed using nix
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { nix = { "alejandra" } } })
    end,
  },
}
