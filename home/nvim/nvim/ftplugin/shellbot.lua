-- source: https://github.com/wincent/wincent/blob/main/aspects/nvim/files/.config/nvim/ftplugin/shellbot.lua
vim.bo.textwidth = 0
vim.wo.list = false
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.showbreak = "NONE"

local has_shellbot = pcall(require, "shellbot")
if has_shellbot then
  vim.keymap.set({ "i", "n" }, "<M-CR>", ":ChatGPTSubmit", { buffer = true })
end
