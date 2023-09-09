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
 require("lazy").setup{
  spec = {
    { import = "user.plugins.core" },
    { import = "user.plugins.editor" },
    { import = "user.plugins.editor.lsp" },
    { import = "user.plugins.ui" },
  },
  install = {
    colorscheme = { "iceberg", "nightfly" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}
