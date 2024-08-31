return {
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

      -- vim.cmd.colorscheme("carbonfox")
      vim.cmd.colorscheme("terafox")
      -- vim.cmd.colorscheme("nightfox")
    end,
  },
}
