return {
	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- main = "null-ls",
          config = function ()
      local nullls = require "null-ls"

      nullls.setup({
        debug = false,
        -- Configure sources which are not installable via `mason-null-ls`
        sources = {
          -- nullls.builtins.formatting.prismaFmt,
          nullls.builtins.formatting.terraform_fmt,
          nullls.builtins.diagnostics.shellcheck,
          nullls.builtins.code_actions.shellcheck,
        }
      })
    end,
    keys = {
      {
        "<localleader>fm",
        -- stylua: ignore
        function() vim.lsp.buf.format { async = true } end,
        mode = { "n", "v" },
        { desc = "Format" }
      },
    }
  },

	{
		"jay-babu/mason-null-ls.nvim",
     event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = {
			-- list of formatters & linters for mason to install
			ensure_installed = {
				"prettierd", -- ts/js formatter
        "eslint_d", -- ts/js linter
				"stylua", -- lua formatter
        "shfmt",
			},
			automatic_installation = true,
      handlers = {}, -- auto register all `ensure_installed` plugins with null-ls
		},
	},
}
