return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- neo-tree will lazily load itself
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    keys = {
      { "<leader>fe", ":Neotree source=filesystem reveal=true position=right action=show toggle<cr>", desc = "[f]ile [e]xplorer" },
      { "<leader>ng", ":Neotree source=git_status position=float toggle<cr>", desc = "[n]eo-tree [g]it status" },
      { "<leader>fb", ":Neotree source=buffers position=float toggle<cr>", desc = "[f]ind [b]uffers" },
    },
  },
}
