-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "\\", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "s", "<Nop>", { silent = true })

-- Press 'S' for quick find/replace for the word under cursor
-- see: github.com/dmmulroy/kickstart.nix/
vim.keymap.set("n", "S", function()
  local cmd = ":%s/<C-g><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("n", "x", '"_x') -- delete character without adding to register
-- == Navigation, keeping cursor center of page
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "g,", "g,zvzz")
vim.keymap.set("n", "g;", "g;zvzz")
-- split windows
vim.keymap.set("n", "<leader>sv", "<C-w>s", { desc = "" })
vim.keymap.set("n", "<leader>sh", "<C-w>v", { desc = "" })
vim.keymap.set("n", "<leader>s^", "<C-w>^", { desc = "Open split, using the alternative file in the split" })
vim.keymap.set("n", "<leader>sn", "<C-w>n", { desc = "Open split with new empty file" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "equalise windows" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "close window under cursor" })

-- == Resize windows with arrows
vim.keymap.set("n", "<S-Up>", ":resize +2<CR>", { desc = "[R]esize buffer [U]p" })
vim.keymap.set("n", "<S-Down>", ":resize -2<CR>", { desc = "[R]esize buffer [D]own" })
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { desc = "[R]esize buffer [L]eft" })
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { desc = "[R]esize buffer [R]ight" })

-- == Navigate buffers
vim.keymap.set("n", "<TAB>", "<Nop>", { desc = "" })
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "" })

vim.keymap.set("n", "<S-TAB>", "<Nop>", { desc = "" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "", silent = true })
-- == Misc
vim.keymap.set("n", "<localleader>X", "<cmd>!chmod +x %<CR>", { desc = "Make file e[X]ecutable" })
-- Insert blank line
vim.keymap.set("n", "]<Space>", "o<Esc>", { desc = "" })
vim.keymap.set("n", "[<Space>", "O<Esc>", { desc = "" })

vim.keymap.set("i", "jk", "<ESC>", { desc = "" }) -- Press jk fast to exit insert mode

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv^", { desc = "" })
vim.keymap.set("v", ">", ">gv^", { desc = "" })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "" })

-- Diagnostic keymaps
local function _diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil

  return function()
    go({ severity = severity })
  end
end
-- stylua: ignore start
vim.keymap.set("n", "]d", function() _diagnostic_goto(true) end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "[d", function() _diagnostic_goto(false) end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]e", function() _diagnostic_goto(true, "ERROR") end, { desc = "Go to next [E]rror message" })
vim.keymap.set("n", "[e", function() _diagnostic_goto(false, "ERROR") end, { desc = "Go to previous [E]rror message" })
vim.keymap.set("n", "]w", function() _diagnostic_goto(true, "WARNING") end, { desc = "Go to next [W]arning message" })
vim.keymap.set("n", "[w", function() _diagnostic_goto(false, "WARNING") end, { desc = "Go to previous [W]arning message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show [D]iagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<localleader>do", function() vim.diagnostic.open_float({ border = "rounded" }) end, { desc = "[D]iagnostic [O]pen float" })
-- stylua: ignore end

vim.keymap.set("n", "<localleader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" }) -- Place all dignostics into a qflist
vim.keymap.set("n", "<localleader>cn", ":cnext<cr>zz", { desc = "Nav to [N]ext Quickfix item" })
vim.keymap.set("n", "<localleader>cp", ":cprevious<cr>zz", { desc = "Nav to [P]revious Quickfix item" })
vim.keymap.set("n", "<localleader>co", ":copen<cr>zz", { desc = "[O]pen Quickfix list" })
vim.keymap.set("n", "<localleader>cc", ":cclose<cr>zz", { desc = "[C]lose Quickfix list" })

-- stylua: ignore start
vim.keymap.set("n", "<localleader>fm", function() vim.lsp.buf.format() end, { desc = "[F]or[m]at the current buffer" })
-- stylua: ignore end
-- Press leader rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate split [W]indows" })
-- Press gx to open the link under the cursor
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", { silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --
-- --  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
