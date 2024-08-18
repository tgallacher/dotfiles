return {
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main",
      styles = { transparency = true },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)

      vim.cmd.colorscheme("rose-pine")
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        -- transparent = true,
        styles = { comments = "italic" },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)

      -- `terafox` also looks really good
      vim.cmd.colorscheme("carbonfox")
      -- vim.cmd.colorscheme("terafox")
    end,
  },
}
