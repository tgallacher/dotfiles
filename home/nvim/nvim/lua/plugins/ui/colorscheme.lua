return {
  -- {
  --   "rose-pine/neovim",
  --   enabled = false,
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     variant = "main",
  --     -- disable_background = true,
  --     dim_inactive_windows = true,
  --     -- styles = {
  --     --   -- transparency = true,
  --     -- },
  --   },
  --   config = function(_, opts)
  --     require("rose-pine").setup(opts)
  --
  --     vim.cmd.colorscheme("rose-pine")
  --
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "#191724" })
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191724" })
  --   end,
  -- },

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
  --   -- enabled = false,
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
  --

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   config = function()
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "dim" -- 'bright' | 'dim'
      vim.g.gruvbox_material_statusline_style = "mix" -- 'default' | 'mix' | 'original'
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_menu_selection_background = "orange"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored" -- 'grey' | 'colored' | 'highlighted'

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  --   -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  --   -- In Vim, compat mode is turned on as Lush only works in Neovim.
  --   dependencies = "rktjmp/lush.nvim",
  --   -- enabled = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.zenbones_darken_comments = 65
  --     vim.cmd.colorscheme("kanagawabones")
  --   end,
  -- },
}
