-- 
-- Plugin "nvim-tree/nvim-tree.lua"
--
local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        -- default = "",
        -- symlink = "",
        -- folder = {
        --   arrow_open = "",
        --   arrow_closed = "",
        --   default = "",
        --   open = "",
        --   empty = "",
        --   empty_open = "",
        --   symlink = "",
        --   symlink_open = "",
        -- },
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          -- unstaged = "",
          -- staged = "S",
          -- unmerged = "",
          -- renamed = "➜",
          -- untracked = "U",
          -- deleted = "",
          -- ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "-",
          ignored = "◌",
        }
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    preserve_window_proportions = true,
    adaptive_size = false,
    side = "left",
    width = 40,
  },
})

-- KEYMAPS --
vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc="Focus nvimtree", noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc="Toggle nvimtree" })

