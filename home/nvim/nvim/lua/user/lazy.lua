-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- note: all `.lua` files are autoloaded from any folder which is defined here
-- note: this includes `<folder>/init.lua` files
require("lazy").setup({
  spec = {
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.pde" },
  },
  -- install = {
  --   colorscheme = { "terafox" },
  -- },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = { notify = false },
  ui = {
    border = "single",
  },
})
