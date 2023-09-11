return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim" -- vscode-like pictograms on completion popover
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local neogen = require "neogen"
      local compare = require "cmp.config.compare"

      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end
      local source_names = {
        nvim_lsp = "(LSP)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
        path = "(Path)",
      }
      local duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      }
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        }, 
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.score,
            compare.recently_used,
            compare.offset,
            compare.exact,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
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
            maxwidth = 80,
            ellipsis_char = "...",
          }),
        },
        sources = cmp.config.sources {
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
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
          },
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Auto pairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end
  },

  {
    "L3MON4D3/LuaSnip", --snippet engine
    -- event = "InsertEnter",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = function()
      local types = require "luasnip.util.types"
      return {
        history = true,
        delete_check_events = "TextChanged",

        -- Display a cursor-like placeholder in unvisited nodes of the snippet.
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              -- virt_text_pos = "inline",
            },
          },
          [types.exitNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              -- virt_text_pos = "inline",
            },
          },
        },
      }
    end,
    -- stylua: ignore
    keys = {
      {
        "<C-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
        end,
        expr = true, remap = true, silent = true, mode = "i",
      },
      { "<C-j>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<C-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      -- Load personal snippets
      -- local snippets_folder = vim.fn.stdpath "config" .. "/lua/users/plugins/editer/cmp/snippets/"
      -- require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

      -- vim.api.nvim_create_user_command("LuaSnipEdit", function()
      --   require("luasnip.loaders.from_lua").edit_snippet_files()
      -- end, {})
    end,
  },
  -- buffer completions
  
}
