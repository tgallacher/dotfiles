-- FIXME: Update to nvim 0.11 setup when this LSP is required
local servers = {
  -- linter / formatter, etc
  biome = {},
  denols = {},
}

-- TODO: Add note to call out what this does and why we need to set it
vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

return {}

-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "javascript",
--         "typescript",
--         "tsx",
--       })
--     end,
--   },
--
--   {
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), {}))
--       return opts
--     end,
--   },
--
--   -- { -- Lint
--   --   "mfussenegger/nvim-lint",
--   --   opts = function(_, opts)
--   --     return vim.tbl_deep_extend("force", opts, {
--   --       linters_by_ft = {
--   --         typescript = { "biomejs" },
--   --         -- javascript = { "biomejs" },
--   --       },
--   --     })
--   --   end,
--   -- },
--
--   -- { -- Autoformat
--   --   "stevearc/conform.nvim",
--   --   opts = function(_, opts)
--   --     return vim.tbl_deep_extend("force", {
--   --       formatters_by_ft = {
--   --         javascript = { "biome" },
--   --         typescript = { "biome" },
--   --       },
--   --     }, opts)
--   --   end,
--   -- },
-- }
