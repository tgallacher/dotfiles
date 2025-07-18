-- FIXME: Update to nvim 0.11 setup when this LSP is required
local servers = {
  bashls = {},
}

return {} -- tmp disable
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "bash" })
--       return opts
--     end,
--   },
--
--   {
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "shfmt", "shellcheck" }))
--       return opts
--     end,
--   },
--
--   { -- Autoformat
--     "stevearc/conform.nvim",
--     opts = function(_, opts)
--       return vim.tbl_deep_extend("force", opts, {
--         formatters_by_ft = {
--           sh = { "shfmt" },
--         },
--       })
--     end,
--   },
-- }
