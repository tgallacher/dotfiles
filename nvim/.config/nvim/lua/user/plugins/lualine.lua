--
-- Plugin: "nvim-lualine/lualine.nvim" 
--

-- local status_ok, lualine = pcall(require, "lualine")
-- if not status_ok then
-- 	return
-- end
-- 
-- local hide_in_width = function()
-- 	return vim.fn.winwidth(0) > 80
-- end
-- 
-- local diagnostics = {
-- 	"diagnostics",
-- 	sources = { "nvim_diagnostic" },
-- 	sections = { "error", "warn" },
-- 	symbols = { 
--     error = " ",
--     warn = " " 
--   },
-- 	colored = false,
-- 	update_in_insert = false,
-- 	always_visible = true,
-- }
-- 
-- local diff = {
-- 	"diff",
-- 	colored = false,
-- 	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
--   cond = hide_in_width
-- }
-- 
-- local mode = {
-- 	"mode",
-- 	fmt = function(str)
-- 		return "-- " .. str .. " --"
-- 	end,
-- }
-- 
-- local filetype = {
-- 	"filetype",
-- 	icons_enabled = false,
-- 	icon = nil,
-- }
-- 
-- local branch = {
-- 	"branch",
-- 	icons_enabled = true,
-- 	icon = "",
-- }
-- 
-- local location = {
-- 	"location",
-- 	padding = 0,
-- }
-- 
-- -- cool function for progress
-- local progress = function()
-- 	local current_line = vim.fn.line(".")
-- 	local total_lines = vim.fn.line("$")
-- 	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
-- 	local line_ratio = current_line / total_lines
-- 	local index = math.ceil(line_ratio * #chars)
-- 	return chars[index]
-- end
-- 
-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end
-- 
-- lualine.setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = "auto",
-- 		component_separators = "|", 
-- 		-- component_separators = { left = "", right = "" },
-- 		section_separators = { left = "", right = "" },
-- 		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
-- 		always_divide_middle = true,
-- 	},
-- 	sections = {
-- 		lualine_a = { branch, diagnostics },
-- 		lualine_b = { mode },
-- 		lualine_c = {},
-- 		-- lualine_x = { "encoding", "fileformat", "filetype" },
-- 		lualine_x = { diff, spaces, "encoding", filetype },
-- 		lualine_y = { location },
-- --		lualine_z = { progress },
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = { "filename" },
-- 		lualine_x = { "location" },
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 	},
-- 	tabline = {},
-- 	extensions = {},
-- })



-- Credit: based on "omerxx/dotfiles"



-- Set lualine as statusline
-- See `:help lualine.txt`
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify("Failed to load lualine..")
	return
end

-- local mode = {
-- 	"mode",
-- 	fmt = function(str)
-- 		return "-- " .. str .. " --"
-- 	end,
-- }


local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { 
    error = " ",
    warn = " " 
  },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

lualine.setup({
  options = {
    theme = "iceberg_dark",
    icons_enabled = true,
    component_separators = "|",
    section_separators = "",
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { diagnostics, "buffers", "diff" },
    lualine_x = {
      {
        require("noice").api.status.message.get_hl,
        cond = require("noice").api.status.message.has,
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.search.get,
        cond = require("noice").api.status.search.has,
        color = { fg = "#ff9e64" },
      },   
    },
    lualine_y = {  "filetype" },
    lualine_z = { "branch" }
  }
})
