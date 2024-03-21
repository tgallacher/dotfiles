require("user.options")
require("user.lazy")

if vim.fn.argc(-1) == 0 then
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("usr", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      require("user.keymaps")
      require("user.autocmds")
    end,
  })
else
  require("user.keymaps")
  require("user.autocmds")
end
