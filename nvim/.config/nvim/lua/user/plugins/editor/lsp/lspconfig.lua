local lsp = require("user.plugins.config").lsp

return {
  -- bridge gap between Mason + Lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = lsp.servers,
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
			for _, server in pairs(lsp.servers) do
				local opts = { on_attach = on_attach, capabilities = capabilities }
				server = vim.split(server, "@")[1]

				-- merge overrides if defined
				if lsp.serverConfigs[server] then
					opts = vim.tbl_deep_extend("force", lsp.serverConfigs[server], opts)
				end

        if server == "tsserver" then
          -- TS server doesn't follow the std config syntax :|
          opts = { server = opts }
        end
        lspconfig[server].setup(opts)
			end

			-- -- configure Diagnostic symbols in signcolumn
			-- for _, sign in ipairs(signs) do
			-- 	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			-- end

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		end,
	},
}
