local palette = require("catppuccin.palettes").get_palette("mocha")
return {
  { -- screen capture code
    "michaelrommel/nvim-silicon",
    dependencies = { "folke/which-key.nvim" },
    lazy = true,
    cmd = "Silicon",
    -- init = function()
    --   require("which-key").register({ ["<localleader>sc"] = { ":Silicon<cr>", "[S]napshot [C]ode" } }, { mode = "v" })
    -- end,
    keys = {
      { "<localleader>sc", ":Silicon<cr>", desc = "[S]napshot [C]ode", mode = "v" },
    },
    config = function()
      require("silicon").setup({
        font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
        theme = "Dracula",
        background = palette.lavendar,
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end,
      })
    end,
  },
}
