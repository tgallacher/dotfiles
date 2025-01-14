-- [[ Basic Keymaps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "v" }, "s", "<Nop>", { silent = true })
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
vim.keymap.set("n", "<leader>sv", "<C-w>s", { desc = "Create [s]plit [v]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>v", { desc = "Create [s]plit [h]orizontally" })
vim.keymap.set("n", "<leader>s^", "<C-w>^", { desc = "Create [s]plit using the [^] alternate file" })
vim.keymap.set("n", "<leader>sn", "<C-w>n", { desc = "Create [s]plit with a [n]ew file" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "[s]plit windows [e]qually" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close [s]plit window under cursor [x]" })
vim.keymap.set("n", "<leader>sr", ":RotateWindows<cr>", { desc = "[r]otate [s]plit windows" })

-- == Resize windows with arrows
vim.keymap.set("n", "<S-Up>", ":resize +2<CR>", { desc = "[R]esize buffer [U]p" })
vim.keymap.set("n", "<S-Down>", ":resize -2<CR>", { desc = "[R]esize buffer [D]own" })
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { desc = "[R]esize buffer [L]eft" })
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { desc = "[R]esize buffer [R]ight" })

-- == Navigate buffers
vim.keymap.set("n", "<TAB>", "<Nop>")
vim.keymap.set("n", "<S-TAB>", "<Nop>")
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "[b]uffer: switch to one on right" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "[b]uffer: switch to one on left" })

-- == Misc
vim.keymap.set("n", "<localleader>X", ":!chmod +x %<CR>", { desc = "Make file e[X]ecutable" })
vim.keymap.set("n", "]<Space>", "o<Esc>", { desc = "" }) -- Insert blank line below
vim.keymap.set("n", "[<Space>", "O<Esc>", { desc = "" }) -- Insert blank line above
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>", { noremap = true, silent = true }) -- open the link under the cursor
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "" }) -- Press jk fast to exit insert mode

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv^", { desc = "" })
vim.keymap.set("v", ">", ">gv^", { desc = "" })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "" })

-- FIXME: stops at copy
vim.keymap.set("n", "<localleader>ctl", "yiWysiW]%a()<ESC>P<ESC>", { desc = "[c]onvert [t]o [l]ink (markdown)" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
