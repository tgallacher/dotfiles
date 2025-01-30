return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
    dependencies = {
      {-- Automatically install LSPs and related tools to stdpath for neovim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          { "williamboman/mason.nvim", opts = { ui = { border = "single" }, }, },
        },
        opts = {
          ensure_installed = {},
          run_on_start = true,
        },
      },
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      diagnostics = {
        underline = true,
        severity_sort = true,
        inlay_hints = { enable = true },
        codelens = { enable = true },
      },
      servers = {}, -- INFO: PDE lang files will populate this separately
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local goto_diagnostic = function (dirPrev, severity)
            local goto = dirPrev and vim.diagnostic.goto_prev or vim.diagnostic.goto_next
            severity = severity and vim.diagnostic.severity[severity] or nil

            goto({ severity = severity, float = { border = "single"}})
          end

          -- stylua: ignore start
          map("n", "[d", function() goto_diagnostic(true) end, "Go to Prev [d]iagnostics")
          map("n", "]d", function() goto_diagnostic(false) end, "Go to Next [d]iagnostics")
          map("n", "[e", function() goto_diagnostic(true, "ERROR") end, "Go to Prev [e]rror")
          map("n", "]e", function() goto_diagnostic(false, "ERROR") end, "Go to Next [e]rror")
          map("n", "[w", function() goto_diagnostic(true, "WARNING") end, "Go to Prev [w]arning")
          map("n", "]w", function() goto_diagnostic(false, "WARNING") end, "Go to Next [w]arning")

          -- TODO: Adjust after nvim 0.11 has been released
          map("n", "gd", require("telescope.builtin").lsp_definitions, "[g]o to [d]efinition")
          map("n", "gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
          map("n", "gr", function() require("telescope.builtin").lsp_references({ trim_text = true, fname_width = 50 }) end, "Show LSP [r]eferences")
          map("n", "gi", require("telescope.builtin").lsp_implementations, "[g]o to [i]implementation")
          map("n", "gt", require("telescope.builtin").lsp_type_definitions, "[g]o to [t]ype definition")
          map("n", "gs", require("telescope.builtin").lsp_document_symbols, "Show document [s]ymbols")
          map("n", "gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Show workspace [S]ymbols")
          map("n", "grr", vim.lsp.buf.rename, "[r]e[n]ame")
          map("n", "gra", vim.lsp.buf.code_action, "[c]ode [a]ction")
          map("n", "K", vim.lsp.buf.hover, "Show Hover Documentation") --  See `:help K` for why this keymap
          map({ "n", "i" }, "<C-K>", vim.lsp.buf.signature_help, "Signature documentation")
          map("n", "<localleader>dd", ":Telescope diagnostics bufnr=0<CR>", "Show [d]ocument [d]iagnostics")
          map("n", "<localleader>dl", function() vim.diagnostic.open_float({ source = true }) end, "Show [d]iagnostic for [l]ine")
          map("n", "<localleader>dq", vim.diagnostic.setloclist, "Send all [d]iagnostics to [q]uickfix list")
          map("n", "<localleader>qd", vim.diagnostic.setqflist, "Set [q]uickfix list to [d]iagnostics")
          map("n", "<localleader>fm", vim.lsp.buf.format, "[f]or[m]at the current buffer")

          map("n", "<localleader>qn", ":cnext<cr>zz", "Jump to [q]uickfix [n]ext item")
          map("n", "<localleader>qp", ":cprevious<cr>zz", "Jump to [q]uickfix [p]rev item")
          map("n", "<localleader>qo", ":copen<cr>zz", "[q]uickfix [o]pen list")
          map("n", "<localleader>qc", ":cclose<cr>zz", "[q]uickfix [c]lose list")


          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
      --
      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason").setup()
      require("mason-lspconfig").setup({
        -- INFO: this will be auto populated within each lang pde file
        ensure_installed = {  },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = opts.servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })


      -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
      local open_floating_preview = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, _opts, ...)
        opts = _opts or {}
        opts.border = opts.border or "rounded" -- Set border to rounded
        return open_floating_preview(contents, syntax, opts, ...)
      end
    end,
  },

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",-- Snippet Engine & its associated nvim-cmp source
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          -- Enable luasnip to handle snippet expansion for nvim-cmp
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" }, -- TODO: what does this do?
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete({}),
          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function() if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function() if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
