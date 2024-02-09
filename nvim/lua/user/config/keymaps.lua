-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("", "s", "<Nop>", opts)

-- unset conflicting cmds
keymap("", "<leader>x", "<Nop>", opts)
keymap("", "<leader>f", "<Nop>", opts)
keymap("", "gb", "<Nop>", opts)
keymap("", "gc", "<Nop>", opts)

--#######################################################
-- GENERAL
--#######################################################

----------------------------------------------------------
-- Normal --
----------------------------------------------------------
-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap("n", "<leader>nh", ":nohl<CR>")

keymap("n", "x", '"_x') -- delete character without adding to register

-- == Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- == Navigation, keeping cursor center of page
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- split windows
keymap("n", "<leader>sh", "<C-w>s", opts)
keymap("n", "<leader>sv", "<C-w>v", opts)
keymap("n", "<leader>s^", "<C-w>^", opts)     -- Open split, using the alternative file in the split
keymap("n", "<leader>sn", "<C-w>n", opts)     -- Open split with new empty file
keymap("n", "<leader>se", "<C-w>=", opts)     -- equalise windows
keymap("n", "<leader>sx", ":close<CR>", opts) -- close window under cursor

-- == Resize windows with arrows
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- == Navigate buffers
keymap("n", "<C-S-l>", "<Nop>", opts)
keymap("n", "<C-S-l>", ":bnext<CR>", opts)

keymap("n", "<C-S-h>", "<Nop>", opts)
keymap("n", "<C-S-h>", ":bprevious<CR>", opts)

keymap("n", "<A-x>", "<Nop>", opts)
keymap("n", "<A-x>", ":bdelete<CR>", opts)

-- == Move text up and down
-- FIXME: Conflict with Tmux hotkeys
keymap("n", "<A-J>", ":m .+1<CR>==", opts)
keymap("n", "<A-K>", ":m .-2<CR>==", opts)

-- == Misc
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })
-- Insert blank line
keymap("n", "]<Space>", "o<Esc>", opts)
keymap("n", "[<Space>", "O<Esc>", opts)

----------------------------------------------------------
-- Insert --
----------------------------------------------------------
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Auto indent
keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
----------------------------------------------------------
-- Visual --
----------------------------------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
-- FIXME: Conflict with Tmux hotkeys
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', opts)

----------------------------------------------------------
-- Visual Block --
----------------------------------------------------------
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
-- FIXME: Conflict with Tmux hotkeys
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

----------------------------------------------------------
-- Terminal --
----------------------------------------------------------
local term_opts = { silent = true }
--
-- Better terminal navigation
keymap("t", "<C-[>", "<C-\\><C-n>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
