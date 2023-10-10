return {
  -- token parser
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- mainline
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "gitignore",
        -- zmk
        "kconfig",
        "devicetree",
      },
      highlight = {
        enable = true,
        disable = { "css" },
      },
      autopairs = { enable = true },
      autotag = { enable = true },
      indent = {
        enable = true,
        disable = { "python", "css" },
      },
      illuminate = { enable = true },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },
}
