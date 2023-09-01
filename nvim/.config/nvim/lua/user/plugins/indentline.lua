-- 
-- Plugin: "lukas-reineke/indent-blankline.nvim"
--
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  vim.notify "Failed to load indent_blankline.."
	return
end

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
}
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}
-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

-- local colors = require "user.plugins.colorscheme.colors"
--
-- vim.cmd(string.format([[highlight IndentBlanklineIndent1 guifg=%s gui=nocombine]], colors.color_9))
-- vim.cmd(string.format([[highlight IndentBlanklineIndent2 guifg=%s gui=nocombine]], colors.color_9))
-- vim.cmd(string.format([[highlight IndentBlanklineIndent3 guifg=%s gui=nocombine]], colors.color_9))
-- vim.cmd(string.format([[highlight IndentBlanklineIndent4 guifg=%s gui=nocombine]], colors.color_9))
-- vim.cmd(string.format([[highlight IndentBlanklineIndent5 guifg=%s gui=nocombine]], colors.color_9))
-- vim.cmd(string.format([[highlight IndentBlanklineIndent6 guifg=%s gui=nocombine]], colors.color_9))

vim.cmd(string.format([[highlight IndentBlanklineIndent1 guifg=%s gui=nocombine]], "#1e2132"))
vim.cmd(string.format([[highlight IndentBlanklineIndent2 guifg=%s gui=nocombine]], "#1e2132"))
vim.cmd(string.format([[highlight IndentBlanklineIndent3 guifg=%s gui=nocombine]], "#1e2132"))
vim.cmd(string.format([[highlight IndentBlanklineIndent4 guifg=%s gui=nocombine]], "#1e2132"))
vim.cmd(string.format([[highlight IndentBlanklineIndent5 guifg=%s gui=nocombine]], "#1e2132"))
vim.cmd(string.format([[highlight IndentBlanklineIndent6 guifg=%s gui=nocombine]], "#1e2132"))

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
vim.opt.listchars:append "eol:↴"

indent_blankline.setup({
  show_end_of_line = true,
  space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
	  "IndentBlanklineIndent1",
	  "IndentBlanklineIndent2",
	  "IndentBlanklineIndent3",
	  "IndentBlanklineIndent4",
	  "IndentBlanklineIndent5",
	  "IndentBlanklineIndent6",
	},
})
