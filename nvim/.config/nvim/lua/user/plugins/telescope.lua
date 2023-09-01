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
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
        ["C-h"] = "which_key",
      },
    },
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
  -- extensions = {
  --   -- Your extension configuration goes here:
  --   -- extension_name = {
  --   --   extension_config_key = value,
  --   -- }
  --   -- please take a look at the readme of the extension you want to configure
  -- },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, "fzf-native")

