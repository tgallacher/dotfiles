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
