return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")

      -- You can configure highlights by doing something like
      vim.cmd.hi("Comment gui=none")
    end,
    opts = {
      transparent_background = true,
      no_italic = false,
      no_bold = false,
      integrations = {
        -- only plugins which have been changed from their defaults are here
        fidget = true,
        harpoon = true,
        mason = true,
        which_key = true,
      },
    },
  },
}
