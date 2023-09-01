-- Keymaps
-- Note: Plugin related keymaps live alongside each plugin config file
--
local opts = { noremap = true, silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

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

--#######################################################
-- PLUGINS
--#######################################################

-- folke/twilight
vim.keymap.set("n", "<leader>tw", "<cmd> :Twilight <CR>", opts)

-- "folke/zen-mode.nvim"
vim.keymap.set("n", "<leader>zm", "<cmd> :ZenMode <CR>", opts)
-- 
-- "f-person/git-blame"
vim.keymap.set("n", "<leader>gb", "<cmd> :GitBlameToggle <CR>", opts)

-- glepnir/lspsaga.nvim 
vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd> Lspsaga term_toggle <CR>")

-- Telescope
local telescope_builtins = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", "<Nop>", opts)

vim.keymap.set("n", "<leader>ff", telescope_builtins.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fa", function() telescope_builtins.find_files({ no_ignore=true, follow=true, hidden=false }) end, { desc = "Find all files"} )
vim.keymap.set("n", "<leader>fw", telescope_builtins.live_grep, { desc = "Find text in cwd" })
vim.keymap.set("n", "<leader>fs", telescope_builtins.grep_string, { desc = "Find text under cursor in cwd" })
vim.keymap.set("n", "<leader>fgf", telescope_builtins.git_files, { desc = "Find file known to git" })
vim.keymap.set("n", "<leader>fb", telescope_builtins.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>fo", telescope_builtins.oldfiles, { desc = "Find previously opened file"})
vim.keymap.set("n", "<leader>fq", telescope_builtins.quickfix, { desc = "Find in quickfix list"})
vim.keymap.set("n", "<leader>fib", telescope_builtins.current_buffer_fuzzy_find, { desc = "Find text inside current buffer"})
vim.keymap.set("n", "<leader>fgb", telescope_builtins.git_bcommits, { desc = "List git commits for current buffer"})
vim.keymap.set("n", "<leader>fgs", telescope_builtins.git_stash, { desc = "List git stashes"})
vim.keymap.set("n", "<leader>fth", telescope_builtins.colorscheme, { desc = "List/preview colorschemes"})

vim.keymap.set("n", "<leader>fh", telescope_builtins.help_tags, { desc = "Help"})

