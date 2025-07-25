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
      opts.ensure_installed =
        vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "markdown-toc", "markdownlint-cli2", "prettierd" }))
      return opts
    end,
  },

  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = function(_, opts)
  --     return vim.tbl_deep_extend("force", opts, {
  --       linters_by_ft = {
  --         -- markdown = { "markdownlint-cli2" },
  --       },
  --     })
  --   end,
  -- },

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

      md.setup(opts)
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters = {
          ["markdown-toc"] = {
            condition = function(_, ctx)
              for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                if line:find("<!%-%- toc %-%->") then
                  return true
                end
              end
            end,
          },
          ["markdownlint-cli2"] = {
            condition = function(_, ctx)
              local diag = vim.tbl_filter(function(d)
                return d.source == "markdownlint"
              end, vim.diagnostic.get(ctx.buf))
              return #diag > 0
            end,
          },
        },
        formatters_by_ft = {
          markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
          ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        },
      })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
