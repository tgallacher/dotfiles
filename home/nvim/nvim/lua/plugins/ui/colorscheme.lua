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
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main",
      -- dim_inactive_windows = true,
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

  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        -- transparent = true,
        styles = {
          comments = "italic",
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)

      vim.cmd.colorscheme("carbonfox")
      -- vim.cmd.colorscheme("terafox")
    end,
  },
}
