-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- unset conflicting cmds
vim.keymap.set("", "<leader>x", "<Nop>", opts)
vim.keymap.set("", "<leader>f", "<Nop>", opts)
vim.keymap.set("", "gb", "<Nop>", opts)
vim.keymap.set("", "gc", "<Nop>", opts)

--#######################################################
-- GENERAL
--#######################################################

----------------------------------------------------------
-- Normal --
----------------------------------------------------------
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "x", '"_x')       -- delete character without adding to register

-- == Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- split windows
vim.keymap.set("n", "<leader>sv", "<C-w>s", opts)
vim.keymap.set("n", "<leader>sh", "<C-w>h", opts)
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- equalise windows
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts) -- close window under cursor

-- == Navigation, keeping cursor center of page
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- == Resize with arrows (conflict with OSX global OS keybinds)
-- vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- == Navigate buffers
vim.keymap.set("n", "<A-]>", "<Nop>", opts)
vim.keymap.set("n", "<A-[>", "<Nop>", opts)
vim.keymap.set("n", "<A-x>", "<Nop>", opts)
vim.keymap.set("n", "<A-]>", ":bnext<CR>", opts)
vim.keymap.set("n", "<A-[>", ":bprevious<CR>", opts)
-- FIXME: no working with corne keyboard
vim.keymap.set("n", "<A-x>", ":bdelete<CR>", opts)

-- == Move text up and down
-- FIXME: no working with corne keyboard
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-- == Misc
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })


----------------------------------------------------------
-- Insert --
----------------------------------------------------------
-- Press jk fast to exit insert mode 
vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "kj", "<ESC>", opts)

----------------------------------------------------------
-- Visual --
----------------------------------------------------------
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv^", opts)
vim.keymap.set("v", ">", ">gv^", opts)

-- Move text up and down
-- FIXME: no working with corne keyboard
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("v", "p", '"_dP', opts)


----------------------------------------------------------
-- Visual Block --
----------------------------------------------------------
-- Move text up and down
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", opts)
-- FIXME: no working with corne keyboard
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

----------------------------------------------------------
-- Terminal --
----------------------------------------------------------
-- local term_opts = { silent = true }
--
-- Better terminal navigation
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

