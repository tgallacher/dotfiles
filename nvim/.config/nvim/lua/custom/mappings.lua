-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")

---@type MappingsTable
local M = {}

M.disabled = {
  i = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
  },

  n = {
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
  },
}


M.general = {
  i = {
    ["<C-c>"] = { "<Esc>", "Ctrl C operate as escape" },
  },

  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["J"] = { "mzJ`z", "unsure" },
    ["<C-d>"] = { "<C-d>zz", "Page down, keeping center cursor" },
    ["<C-u>"] = { "<C-u>zz", "Page up, keeping center cursor" },
    ["n"] = { "nzzzv", "Next search item, keeping center cursor" },
    ["N"] = { ":", "Prev search item, keeping center cursor" },
    ["<leader>X"] = { "<cmd>!chmod +x %<CR>", "Make file executable", { silent = true } },
    -- Ensure better compatibility with tmux
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
  },

  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Drag highlighted text up" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Drag highlighted text up" },
  },
}

M.trouble = {
  n = {
    ["<leader>xt"] = { "<CMD>TroubleToggle<CR>", "Toggle Trouble"},
    ["<leader>xw"] = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Toggle Trouble workspace diagnostics"},
    ["<leader>xd"] = { "<CMD>TroubleToggle document_diagnostics<CR>", "Toggle Trouble document diagnostics"},
    ["<leader>gR"] = { "<CMD>TroubleToggle lsp_references<CR>", "Toggle Trouble LSP references"},
  }
}

-- M.harpoon = {
--   n = {
--     ["<leader>a"] = { mark.add_file, "Add file to harpoon list" },
--     ["<C-e>"] = { ui.toggle_quick_menu, "Toggle Harpoon UI" },
-- 
--     ["<C-h>"] = { function() ui.nav_file(1) end, "Harpoon file at position 1" },
--     ["<C-t>"] = { function() ui.nav_file(2) end, "Harpoon file at position 2" },
--     ["<C-n>"] = { function() ui.nav_file(3) end, "Harpoon file at position 3" },
--     ["<C-s>"] = { function() ui.nav_file(4) end, "Harpoon file at position 4" },
--   }
-- }

return M
