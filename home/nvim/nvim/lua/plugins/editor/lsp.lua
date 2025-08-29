return {
  { -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    lazy = false, -- Load immediately to ensure PATH is set
    dependencies = {
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {},
          run_on_start = true,
        },
      },
    },
    opts = {
      ui = {
        border = "single",
        icons = {
          package_pending = "➜",
          package_installed = "✓",
          package_uninstalled = "✗",
        },
      },
    },
  },

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    enabled = false,
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip", -- Snippet Engine & its associated nvim-cmp source
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "petertriho/cmp-git",
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
          ["<C-S-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-S-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "git" },
        }),
      })
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    enabled = false,
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  {
    "SmiteshP/nvim-navic",
    event = "InsertEnter",
    opts = {
      lsp = {
        auto_attach = true,
        -- preference = { "ts_ls" },
      },
    },
    init = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },
}
