return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    opts = {
      use_default_keymaps = false,
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
    },
    keys = {
      -- stylua: ignore
      { "<leader>o", function() require("oil").toggle_float() end, { desc="Open [o]il.nvim"}},
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
