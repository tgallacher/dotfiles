return {

	-- nightfly
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
    config = function()
      vim.cmd([[colorscheme nightfly]])
    end
	},

	{ "cocopon/iceberg.vim" },

	{ "jaredgorski/spacecamp" },

	-- dogrun
	{ "wadackel/vim-dogrun" },
}
