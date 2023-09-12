require "user.config.settings"
require "user.config.lazy"

if vim.fn.argc(-1) == 0 then
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("tfg", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      require "user.config.keymaps"
      require "user.config.autocmds"
    end,
  })
else
  require "user.config.keymaps"
  require "user.config.autocmds"
end
