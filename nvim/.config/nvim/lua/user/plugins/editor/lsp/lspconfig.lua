local lsp = require("user.plugins.config").lsp
local lsputils = require("user.plugins.editor.lsp.utils.utils")

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
		dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "j-hui/fidget.nvim", config = true, tag = "legacy" },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",

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
				local keymap = vim.keymap.set

				keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
        -- stylua: ignore
				keymap("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, opts) -- got to declaration
				keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
        -- stylua: ignore
				keymap("n", "gi", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, opts) -- go to implementation
        -- stylua: ignore
        keymap("gt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, opts) -- goto type definition
				keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
				keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
				keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
				-- keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
				-- keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
        keymap("]d", lsputils.diagnostic_goto(true), { desc = "Next Diagnostic" })
        keymap("[d", lsputils.diagnostic_goto(false), { desc = "Prev Diagnostic" })
        keymap("]e", lsputils.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
        keymap("[e", lsputils.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
        keymap("]w", lsputils.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
        keymap("[w", lsputils.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })
				keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
        -- stylua: ignore
				keymap("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)
        keymap({"n", "v"},"<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
        -- stylua: ignore
        keymap("n", "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, opts) -- document symbols
        -- stylua: ignore
        keymap("n","<leader>lS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, opts) -- workspace symbols

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

			-- configure Diagnostic symbols in signcolumn
      local icons = require("user.config.icons")
      local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      }
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

      vim.diagnostic.config({
        -- virtual_text = false,
        virtual_text = {
          spacing = 4,
          prefix = icons.ui.Exclamation,
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
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
        }
      })

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		end,
	},
}
