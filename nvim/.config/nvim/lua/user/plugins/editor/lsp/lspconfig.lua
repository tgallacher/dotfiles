local lsp = require("user.plugins.config.lsp")
local lsputils = require "user.plugins.editor.lsp.utils.utils"

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
      { "folke/neoconf.nvim",      cmd = "Neoconf", config = true },
      -- { "j-hui/fidget.nvim",       config = true,   tag = "legacy" },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require "lspconfig"
      local cmp_nvim_lsp = require "cmp_nvim_lsp"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                            -- show definition, references
        keymap("n", "gd", "<cmd>Telescope lsp_definitions reuse_win=true<cr>", opts)      -- got to declaration
        keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)                       -- see definition and make edits in window
        keymap("n", "gi", "<cmd>Telescope lsp_implementations reuse_win=true<cr>", opts)  -- go to implementation
        keymap("n", "gR", "<cmd>Telescope lsp_references reuse_win=true<cr>", opts)  -- go to implementation
        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions reuse_win=true<cr>", opts) -- goto type definition
        keymap("n", "<localleader>rn", "<cmd>Lspsaga rename<CR>", opts)                   -- smart rename
        keymap("n", "<localleader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)     -- show  diagnostics for line
        keymap("n", "<localleader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)   -- show diagnostics for cursor

        -- stylua: ignore start
        keymap("]d", function() lsputils.diagnostic_goto(true) end, { desc = "Next Diagnostic" })
        keymap("[d", function() lsputils.diagnostic_goto(false) end, { desc = "Prev Diagnostic" })
        keymap("]e", function() lsputils.diagnostic_goto(true, "ERROR") end, { desc = "Next Error" })
        keymap("[e", function() lsputils.diagnostic_goto(false, "ERROR") end, { desc = "Prev Error" })
        keymap("]w", function() lsputils.diagnostic_goto(true, "WARNING") end, { desc = "Next Warning" })
        keymap("[w", function() lsputils.diagnostic_goto(false, "WARNING") end, { desc = "Prev Warning" })
        -- stylua: ignore end

        -- keymap("n", "<localleader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
        keymap({ "n", "v" }, "<localleader>ca", "<cmd>Lspsaga code_action<cr>", opts)
        keymap("n", "<localleader>gs", "<cmd>Telescope lsp_document_symbols<cr>", opts)          -- document symbols
        keymap("n", "<localleader>gS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts) -- workspace symbols

        -- typescript specific keymaps (e.g. rename file and update imports)
        if client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false

          keymap.set("n", "<localleader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
          keymap.set("n", "<localleader>ru", ":TypescriptRemoveUnused<CR>")    -- remove unused variables
          keymap.set("n", "<localleader>rf", ":TypescriptRenameFile<CR>")      -- rename file and update imports
        end

        local status_ok, illuminate = pcall(require, "illuminate")
        if status_ok then illuminate.on_attach(client) end
      end

      -- Configure LSP servers
      for _, server in pairs(lsp.servers) do
        local opts = { on_attach = on_attach, capabilities = capabilities }
        server = vim.split(server, "@")[1]

        -- merge overrides if defined
        if lsp.serverConfigs[server] then opts = vim.tbl_deep_extend("force", lsp.serverConfigs[server], opts) end

        -- TS server doesn't follow the std config syntax :|
        if server == "tsserver" then opts = { server = opts } end
        lspconfig[server].setup(opts)
      end

      -- configure Diagnostics
      local icons = require "user.config.icons"
      local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      vim.diagnostic.config {
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
        },
      }

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = "rounded" })
    end,
  },
}
