local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- note: all `.lua` files are autoloaded from in a folder which is defined here
-- note: this includes `<folder>/init.lua` files
 require("lazy").setup{
  spec = {
    { import = "user.plugins.editor" },
    { import = "user.plugins.ui" },
    { import = "user.pde" },
  },
  install = {
    colorscheme = { "rose-pine", "iceberg", "nightfly" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}
