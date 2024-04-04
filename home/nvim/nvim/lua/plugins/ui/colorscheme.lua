return {
  {
    "catppuccin/nvim",
    enabled = false,
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
    lazy = false,
    name = "rose-pine",
    priority = 1000,
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")

      -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ea9a97", bg = "#6e6a86" })
      vim.api.nvim_set_hl(0, "Cursor", { fg = "#ea9a97", bg = "#6e6a86" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#26233a" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ea9a97", bg = "#26233a" })
      -- vim.api.nvim_set_hl(0, "CursorColumn", { fg = "#ea9a97", bg = "#6e6a86" })

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
