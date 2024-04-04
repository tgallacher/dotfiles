return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    main = "nvim-treesitter.configs",
    opts = {
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      ensure_installed = {}, -- languages to install; NOTE: we separate this out into the PDE dir
      auto_install = true, -- Auto-install languages that are not installed
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
