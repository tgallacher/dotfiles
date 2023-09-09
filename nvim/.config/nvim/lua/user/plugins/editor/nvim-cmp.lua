return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim" -- vscode-like pictograms on completion popover
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end

      vim.opt.completeopt = "menu,menuone,noselect"

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          },
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
      }
    end,
  },

  {
    "L3MON4D3/LuaSnip", --snippet engine
    event = "InsertEnter",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    }
  },
  -- buffer completions
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
  -- path completions
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
  -- command line completions
  {
    "hrsh7th/cmp-cmdline",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
  -- sources for LSP server client
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
  -- source for nvim lua API
  {
    "hrsh7th/cmp-nvim-lua",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
  -- a bunch of snippets to use
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp"
    }
  },
}
