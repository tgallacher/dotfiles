-- 
-- Plugin: "nvim-telescope/telescope.nvim"
-- 
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local builtin = require("telescope.builtin")

telescope.setup {
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    path_display = { "smart" },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    planets = {
      show_pluto = true,
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- KEYMAPS --
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({ no_ignore=true, follow=true }) end, { desc = "Find all files"} )
vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find text in cwd" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find file known to git" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find previously opened file"})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find in quickfix list"})
vim.keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Find text inside current buffer"})

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help"})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", "<Nop>", opts)
