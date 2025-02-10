local servers = {
  marksman = {},
}

vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 120
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
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
  --   "OXY2DEV/markview.nvim",
  --   lazy = false, -- Recommended; already lazy-loaded inside plugin
  --   -- ft = "markdown", -- If you decide to lazy-load anyway
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = function()
  --     local presets = require("markview.presets")
  --
  --     return {
  --       markdown = {
  --         headings = presets.headings.marker,
  --         horizontal_rules = presets.horizontal_rules.thick,
  --       },
  --       preview = {
  --         icon_provider = "devicons",
  --       },
  --     }
  --   end,
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function(_, opts)
      local md = require("render-markdown")
      local cmp = require("cmp")

      md.setup(opts)

      -- cmp.setup.buffer({
      --   sources = { name = "render-markdown" },
      -- })
    end,
  },

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
}
