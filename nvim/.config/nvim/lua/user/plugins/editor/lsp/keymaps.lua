local M = {}

function M.new(client, buffer) return setmetatable({ client = client, buffer = buffer }, { __index = M }) end

function M:has(cap) return self.client.server_capabilities[cap .. "Provider"] end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then return end

  vim.keymap.set(
    opts.mode or "n",
    lhs,
    type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil

  return function() go({ severity = severity }) end
end

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  self:map("gf", "Lspsaga lsp_finder", { desc = "show definition, references" })
  self:map("gd", "Telescope lsp_definitions reuse_win=true", { desc = "got to declaration" })
  self:map("gD", "Lspsaga peek_definition", { desc = "see definition and make edits in window" })
  self:map("gi", "Telescope lsp_implementations reuse_win=true", { desc = "show implementations" })
  self:map("gR", "Telescope lsp_references reuse_win=true", { desc = "show references" })
  self:map("gt", "Telescope lsp_type_definitions reuse_win=true", { desc = "goto type definition" })
  self:map("<localleader>rn", "Lspsaga rename", { desc = "smart rename" })
  self:map("<localleader>D", "Lspsaga show_line_diagnostics", { desc = "show diagnostics for line" })
  self:map("<localleader>d", "Lspsaga show_cursor_diagnostics", { desc = "show diagnostics for cursor" })

  -- stylua: ignore start
  self:map("]d", function() diagnostic_goto(true) end, { desc = "Next Diagnostic" })
  self:map("[d", function() diagnostic_goto(false) end, { desc = "Prev Diagnostic" })
  self:map("]e", function() diagnostic_goto(true, "ERROR") end, { desc = "Next Error" })
  self:map("[e", function() diagnostic_goto(false, "ERROR") end, { desc = "Prev Error" })
  self:map("]w", function() diagnostic_goto(true, "WARNING") end, { desc = "Next Warning" })
  self:map("[w", function() diagnostic_goto(false, "WARNING") end, { desc = "Prev Warning" })
  -- stylua: ignore end

  -- keymap("n", "<localleader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
  self:map("<localleader>ca", "Lspsaga code_action", { mode = { "n", "v" } })

  -- TODO:
  -- local format = require("plugins.lsp.format").format
  -- self:map("<leader>lf", format, { desc = "Format Document", has = "documentFormatting" })
  -- self:map("<leader>lf", format, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
  -- self:map("<leader>lr", M.rename, { expr = true, desc = "Rename", has = "rename" })

  -- self:map("<leader>ls", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
  -- self:map("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
  -- self:map("<leader>lw", require("plugins.lsp.utils").toggle_diagnostics, { desc = "Toggle Inline Diagnostics" })
end

return M
