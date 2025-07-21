-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
local function augroup(name)
  return vim.api.nvim_create_augroup("usr_" .. name, { clear = true })
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("kickstart-highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Resize windows to maintain aspect proportions
-- see: github.com/dmmulroy/kickstart.nix
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("WinResize"),
  pattern = "*",
  command = "wincmd =",
  desc = "Auto-resize windows on terminal buffer resize.",
})

-- Swap splits when only 2 windows in split
-- see: github.com/dmmulroy/kickstart.nix
vim.api.nvim_create_user_command("RotateWindows", function()
  local ignored_filetypes = { "nvim-tree", "neo-tree", "fidget", "Outline", "toggleterm", "qf", "notify" }
  local window_numbers = vim.api.nvim_tabpage_list_wins(0)
  local windows_to_rotate = {}

  for _, window_number in ipairs(window_numbers) do
    local buffer_number = vim.api.nvim_win_get_buf(window_number)
    local filetype = vim.bo[buffer_number].filetype

    if not vim.tbl_contains(ignored_filetypes, filetype) then
      table.insert(windows_to_rotate, { window_number = window_number, buffer_number = buffer_number })
    end
  end

  local num_eligible_windows = vim.tbl_count(windows_to_rotate)

  if num_eligible_windows == 0 then
    return
  elseif num_eligible_windows == 1 then
    vim.api.nvim_err_writeln("There is no other window to rotate with.")
    return
  elseif num_eligible_windows == 2 then
    local firstWindow = windows_to_rotate[1]
    local secondWindow = windows_to_rotate[2]

    vim.api.nvim_win_set_buf(firstWindow.window_number, secondWindow.buffer_number)
    vim.api.nvim_win_set_buf(secondWindow.window_number, firstWindow.buffer_number)
  else
    vim.api.nvim_err_writeln("You can only swap 2 open windows. Found " .. num_eligible_windows .. ".")
  end
end, {})

-- Open help pages in vertical split by default
-- see: github.com/dmmulroy/kickstart.nix
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vertical_help"),
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("L")
    vim.cmd.wincmd("=")
  end,
})

-- Enable spell checking / text wrapping for certain filetypes
-- see: github.com/dmmulroy/kickstart.nix
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("edit_text"),
  pattern = { "gitcommit", "markdown", "txt", "plaintext" },
  desc = "Enable spell checking and text wrapping for certain filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.textwidth = 120
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    -- Enable builtin-LSP autocompletion
    -- Note: requires 0.11+
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    -- LSP setup?
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local goto_diagnostic = function(dirPrev, severity)
      local _goto = dirPrev and vim.diagnostic.jump({ count = -1, float = true }) or vim.diagnostic.jump({ count = 1, float = true })
      severity = severity and vim.diagnostic.severity[severity] or nil

      if _goto then
        _goto({ severity = severity, float = { border = "single" } })
      end
    end

    -- stylua: ignore start
    map("n", "[e", function() goto_diagnostic(true, "ERROR") end, "Go to Prev [e]rror")
    map("n", "]e", function() goto_diagnostic(false, "ERROR") end, "Go to Next [e]rror")
    map("n", "[w", function() goto_diagnostic(true, "WARNING") end, "Go to Prev [w]arning")
    map("n", "]w", function() goto_diagnostic(false, "WARNING") end, "Go to Next [w]arning")

    map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
    map("n", "K", vim.lsp.buf.hover, "Show Hover Documentation") --  See `:help K` for why this keymap
    map({ "n", "i" }, "<C-S-K>", vim.lsp.buf.signature_help, "Signature documentation")

    map("n", "<localleader>dl", function() vim.diagnostic.open_float({ source = true }) end, "Show [d]iagnostic for [l]ine")
    map("n", "<localleader>dq", vim.diagnostic.setloclist, "Send all [d]iagnostics to [q]uickfix list")
    map("n", "<localleader>qd", vim.diagnostic.setqflist, "Set [q]uickfix list to [d]iagnostics")

    map("n", "<localleader>fm", vim.lsp.buf.format, "[f]or[m]at the current buffer")

    -- quickfix list shortcuts
    map("n", "<localleader>qn", ":cnext<cr>zz", "Jump to [q]uickfix [n]ext item")
    map("n", "<localleader>qp", ":cprevious<cr>zz", "Jump to [q]uickfix [p]rev item")
    map("n", "<localleader>qo", ":copen<cr>zz", "[q]uickfix [o]pen list")
    map("n", "<localleader>qc", ":cclose<cr>zz", "[q]uickfix [c]lose list")
    -- stylua: ignore end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })

      -- FIXME: Disable native LSP auto-completion so that we can see Blink's
      -- plugin: blink.cmp
      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(false, client.id, event.buf, { autotrigger = false })
      end
    end
  end,
})
