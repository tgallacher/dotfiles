return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    opts = {
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-h>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit", -- this is used to navigate left
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      -- stylua: ignore
      { "<leader>o", function() require("oil").toggle_float() end, { desc="Open [o]il.nvim"}},
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
