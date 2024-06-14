vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "\\", "<Nop>", { noremap = true, silent = true })

--  NOTE: Must happen before plugins/keymaps are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_banner = 0 -- hide annoying banner
vim.g.netrw_preview = 1 -- vsplit

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`
vim.g.editorconfig = true
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.swapfile = false -- creates a swapfile
vim.opt.hidden = true -- navigate buffers without losing unsaved work
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- convert tab to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.softtabstop = 2
vim.opt.foldenable = true -- disable folds
vim.opt.background = "dark" -- ensure dark version of colourschemes are auto selected
vim.opt.numberwidth = 4 -- set number column width {default 4}
vim.opt.wrap = false -- display lines as one long line
vim.opt.linebreak = true -- companion to wrap, don't split words
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.winminwidth = 10 -- set min window size for `szw/vim-maximizer`
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- control whether current mode is displayed at bottom of window

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.timeout = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Better completion experience
vim.opt.completeopt = { "menuone", "noselect" }

-- enable 24-bit colors
vim.opt.termguicolors = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Place a column line
-- vim.opt.colorcolumn = "120"

-- spelling
vim.opt.spelllang = "en_gb"
vim.opt.spell = true

vim.opt.guicursor = {
  "n-v-c:block", -- Normal, visual, command-line: block cursor
  "i-ci-ve:hor25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait300-blinkon200-blinkoff150", -- All modes: blinking settings
  -- "sm:block-blinkwait175-blinkoff250-blinkon175", -- Showmatch: block cursor with specific blinking settings
}

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
