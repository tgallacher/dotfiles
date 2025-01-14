local servers = {
  marksman = {},
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "markdown_inline" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "prettierd" }))
      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { servers = servers })
    end,
  },

  -- {
  --   -- FIXME: https://github.com/iamcco/markdown-preview.nvim/issues/148
  --   "iamcco/markdown-preview.nvim",
  --   -- main = "markdown-preview",
  --   ft = "markdown",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   keys = {
  --     { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
  --   },
  -- },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          md = { "prettierd" },
          mdx = { "prettierd" },
        },
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },
}
