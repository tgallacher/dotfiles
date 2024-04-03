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

  {
    "rose-pine/neovim",
    -- lazy = true,
    name = "rose-pine",
    -- priority = 1000,
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")

      -- You can configure highlights by doing something like
      -- vim.cmd.hi("Comment gui=none")
    end,
    opts = {
      variant = "main",
      -- dim_inactive_windows = true,
      -- styles = {
      --   -- transparency = true,
      -- },
    },
  },
}
