--
-- Plugin: "ojroques/nvim-bufdel"
--
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>x", ":BufDel <CR>", opts)            
vim.keymap.set("n", "<leader>xh", ":BufDelOthers <CR>", opts)    

