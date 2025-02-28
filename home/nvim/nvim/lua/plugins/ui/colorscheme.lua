return {
  {
    "EdenEast/nightfox.nvim",
    enabled = false,
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

      -- vim.cmd.colorscheme("carbonfox")
      -- vim.cmd.colorscheme("terafox")
      vim.cmd.colorscheme("nightfox")
    end,
  },
  {
    "rose-pine/neovim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main",
      -- disable_background = true,
      -- dim_inactive_windows = true,
      -- styles = {
      --   -- transparency = true,
      -- },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)

      vim.cmd.colorscheme("rose-pine")

      vim.api.nvim_set_hl(0, "Normal", { bg = "#191724" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191724" })
    end,
  },

  {

    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      -- style = "night",
      --  on_colors = function(colors)
      --    -- colors.border = "red"
      -- end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
      background = { dark = "dragon" },
      overrides = function(colors)
        return {
          NormalNC = { fg = colors.palette.dragonAsh },
          Normal = { bg = colors.palette.dragonBlack0 },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
