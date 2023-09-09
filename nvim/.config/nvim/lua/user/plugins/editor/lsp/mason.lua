return {
	-- LSP package manager
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "none",
				icons = {
					package_installed = "",
					package_pending = "󰇘",
					package_uninstalled = "",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		},
	},

}
