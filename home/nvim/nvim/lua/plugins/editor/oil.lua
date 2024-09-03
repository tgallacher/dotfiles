return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    opts = {
      use_default_keymaps = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true, -- see :h oil.skip_confirm_for_simple_edit
      view_options = {
        show_hidden = false,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git" or name == "__pycache__"
        end,
      },
      constrain_cursor = "name", -- constrain to filename: only required when additional `columns` is spec'd below
      columns = {
        "icon",
        "permissions",
        "size",
        "type",
      },
    },
    keys = {
      -- stylua: ignore
      { "<leader>o", function() require("oil").toggle_float() end, { desc="Open [o]il.nvim"}},
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
