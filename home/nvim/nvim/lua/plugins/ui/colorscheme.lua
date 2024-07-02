local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#ff9b5e",
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#66729C",
  mauve = "#b18eab",
}

local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- NOTE: must be called after setup()
      vim.cmd.colorscheme("catppuccin")
      --
      -- You can configure highlights by doing something like
      -- vim.cmd.hi("Comment gui=none")
    end,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      no_italic = false,
      no_bold = false,
      integrations = {
        -- only plugins which have been changed from their defaults are here
        fidget = true,
        harpoon = true,
        mason = true,
        which_key = true,
        telescope = {
          enabled = true,
          -- style = "nvchad",
        },
      },
      -- background = {
      --   -- dark = "frappe",
      --   light = "latte",
      -- },
      color_overrides = {
        latte = extend_base({
          text = "#202027",
          subtext1 = "#263168",
          subtext0 = "#4c4f69",
          overlay2 = "#737994",
          overlay1 = "#838ba7",
          base = "#fcfcfa",
          mantle = "#EAEDF3",
          crust = "#DCE0E8",
          pink = "#EA7A95",
          mauve = "#986794",
          red = "#EC5E66",
          peach = "#FF8459",
          yellow = "#CAA75E",
          green = "#87A35E",
        }),
        frappe = extend_base({
          text = "#fcfcfa",
          surface2 = "#535763",
          surface1 = "#3a3d4b",
          surface0 = "#30303b",
          base = "#202027",
          mantle = "#1c1d22",
          crust = "#171719",
        }),
      },
    },
  },

  {
    "rose-pine/neovim",
    enabled = true,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon",
      dim_inactive_windows = true,
      styles = {
        transparency = true,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme("rose-pine")

      -- -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ea9a97", bg = "#6e6a86" })
      -- vim.api.nvim_set_hl(0, "Cursor", { fg = "#ea9a97", bg = "#6e6a86" })
      -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#26233a" })
      -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ea9a97", bg = "#26233a" })
      -- -- vim.api.nvim_set_hl(0, "CursorColumn", { fg = "#ea9a97", bg = "#6e6a86" })
    end,
  },
}
