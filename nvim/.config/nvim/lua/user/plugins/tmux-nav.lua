-- 
-- Plugin: "christoomey/vim-tmux-navigator"
-- 
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Window up" })
