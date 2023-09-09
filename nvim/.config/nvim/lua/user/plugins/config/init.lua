local M = {}

M.lsp = require("user.plugins.config.lsp")


-- local signs = {
-- 	{ name = "DiagnosticSignError", text = "" },
-- 	{ name = "DiagnosticSignWarn", text = "" },
-- 	{ name = "DiagnosticSignHint", text = "" },
-- 	{ name = "DiagnosticSignInfo", text = "󰙎" },
-- }

M.icons = {
  success = "",
  error = "",
  warn = "",
  hint = "",
  info = "󰙎",
  wait = "󰇘",
  add = "+",
  change = "~",
  delete = "_" ,
  topdelete = "‾",
  changedelete = "~",
}

return M
