local lspconfigs = require("user.plugins.lsp._servers")

-- configure Diagnostic symbols in signcolumn
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

return {
	-- LSP package manager
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "none",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = lspconfigs.servers,
			automatic_installation = true,
		},
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
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
			},
			automatic_installation = true,
		},
	},
	-- LSP config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
    main = "lspconfig",
		dependencies = {
			"williamboman/mason.nvim", -- Automatically install LSPs to stdpath for neovim
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				virtual_text = false,
				signs = { active = signs },
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap

				-- set keybinds
				keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
				keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
				keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
				keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
				keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
				keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
				keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
				keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
				keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
				keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
				keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
				keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
				keymap.set("n", "<leader>fm", function()
					vim.lsp.buf.format({ async = true })
				end, opts)

				-- typescript specific keymaps (e.g. rename file and update imports)
				if client.name == "tsserver" then
					client.server_capabilities.documentFormattingProvider = false

					keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
					keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
					keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
				end

				local status_ok, illuminate = pcall(require, "illuminate")
				if status_ok then
					illuminate.on_attach(client)
				end
			end

			-- Configure LSP servers
			for _, server in pairs(lspconfigs.servers) do
				local opts = { on_attach = on_attach, capabilities = capabilities }
				server = vim.split(server, "@")[1]

        -- merge overrides if defined
				if lspconfigs.serverConfigs[server] then
					opts = vim.tbl_deep_extend("force", lspconfigs.serverConfigs[server], opts)
				end

				-- FIXME: set up TS LSP
				-- if server == "tsserver" then
				--   -- TS server doesn't follow the std config syntax :|
				--   typescript.setup({
				--     server = {
				--       capabilities = capabilities,
				--       on_attach = on_attach,
				--     },
				--   })
				-- else
				lspconfig[server].setup(opts)
				-- end
			end

			-- configure Diagnostic symbols in signcolumn
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		end,
	},

	-- LSP UI
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
    main = "lspsaga",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
		opts = {
			-- keybinds for navigation in lspsaga window
			scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
			-- use enter to open file with definition preview
			definition = {
				edit = "<CR>",
			},
			ui = {
				colors = {
					normal_bg = "#022746",
				},
			},
		},
		keys = {
			{ "<A-d>", "<cmd>Lspsaga term_toggle <CR>", mode = { "n", "t" } },
		},
	},

	-- Formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
    main = "null-ls",
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
        main = "mason-null-ls",
				opts = {
					ensure_installed = lspconfigs.servers,
					automatic_installations = false,
					handlers = {},
				},
			},
		},
		opts = {
			debug = false,
			sources = {
				-- 	formatting.prettier,
				-- 	formatting.stylua,
				--    diagnostics.eslint_d.with({ -- js/ts linter
				--      -- only enable eslint if root has .eslintrc.js
				--      condition = function(utils)
				--        -- TODO: add support for all ESLint config file types
				--        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
				--      end,
				--    }),
			},
			-- -- configure format on save
			-- on_attach = function(current_client, bufnr)
			--   if current_client.supports_method("textDocument/formatting") then
			--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			--     vim.api.nvim_create_autocmd("BufWritePre", {
			--       group = augroup,
			--       buffer = bufnr,
			--       callback = function()
			--         vim.lsp.buf.format({
			--           filter = function(client)
			--             --  only use null-ls for formatting instead of lsp server
			--             return client.name == "null-ls"
			--           end,
			--           bufnr = bufnr,
			--         })
			--       end,
			--     })
			--   end
			-- end,
		},
	},
}
