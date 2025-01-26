local sql_ft = { "sql", "mysql", "plsql" }

return {
  -- Auto uppercase SQL keywords
  { "jsborjesson/vim-uppercase-sql", ft = sql_ft },

  { -- Database client interface
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", lazy = true, ft = sql_ft },
    },
    -- WARN: this seems to be required in order to avoid `nvim-cmp` bug
    -- see https://github.com/kristijanhusak/vim-dadbod-completion/issues/53
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dadbod_filtype_cmp", { clear = true }),
        pattern = sql_ft,
        callback = function()
          local cmp = require("cmp")
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end,
      })
    end,
  },
}
