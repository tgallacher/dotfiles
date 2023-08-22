require "user.plugins.lsp.mason"
require "user.plugins.lsp.lspconfig"
require "user.plugins.lsp.lspsaga"
require "user.plugins.lsp.null-ls"


---
--- Keymaps
---
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, { noremap = true, silent = true })
