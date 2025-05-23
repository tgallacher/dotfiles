return {
  {
    "rose-pine/neovim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main",
      -- disable_background = true,
      dim_inactive_windows = true,
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

  -- {
  --   "folke/tokyonight.nvim",
  --   enabled = false,
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "night",
  --     dim_inactive = true,
  --     lualine_bold = true,
  --     --  on_colors = function(colors)
  --     --    -- colors.border = "red"
  --     -- end,
  --   },
  --   config = function(_, opts)
  --     require("tokyonight").setup(opts)
  --
  --     vim.cmd.colorscheme("tokyonight")
  --   end,
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = false,
  --   opts = {
  --     dimInactive = true,
  --     background = { dark = "dragon" },
  --     overrides = function(colors)
  --       return {
  --         NormalNC = { fg = colors.palette.dragonAsh },
  --         Normal = { bg = colors.palette.dragonBlack0 },
  --       }
  --     end,
  --   },
  --   config = function(_, opts)
  --     require("kanagawa").setup(opts)
  --
  --     vim.cmd.colorscheme("kanagawa")
  --   end,
  -- },
}
