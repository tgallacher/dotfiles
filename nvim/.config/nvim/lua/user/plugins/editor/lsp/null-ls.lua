return {
	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		main = "null-ls",
		opts = {
			debug = false,
			-- sources = {
			-- 		require("null-ls").builtins.formatting.prettier,
			-- 		require("null-ls").builtins.formatting.stylua,
   --        require("null-ls").builtins.diagnostics.eslint_d.with({ -- js/ts linter
			-- 	     -- only enable eslint if root has .eslintrc.js
			-- 	     condition = function(utils)
			-- 	       -- todo: add support for all eslint config file types
			-- 	       return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			-- 	     end,
			-- 	  }),
			-- },
		},
    config = true,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = {
			-- list of formatters & linters for mason to install
			ensure_installed = {
				"prettier", -- ts/js formatter
        "eslint_d", -- ts/js linter
				"stylua", -- lua formatter
			},
			automatic_installation = true,
		},
	},
}
