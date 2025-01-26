local servers = {
  -- lua_ls = {
  --   settings = {
  --     Lua = {
  --       diagnostics = {
  --         globals = { "vim" },
  --       },
  --       runtime = { version = "LuaJIT" },
  --       workspace = {
  --         checkThirdParty = false,
  --         -- Tells lua_ls where to find all the Lua files that you have loaded
  --         -- for your neovim configuration.
  --         library = {
  --           "${3rd}/luv/library",
  --           vim.env.VIMRUNTIME,
  --           -- note: this is slower than the `env.VIMRUNTIME` above
  --           -- unpack(vim.api.nvim_get_runtime_file("", true)),
  --         },
  --       },
  --       completion = {
  --         callSnippet = "Replace",
  --       },
  --     },
  --   },
  -- },
}

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { --  cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "stylua" }))
      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { servers = servers })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { formatters_by_ft = { lua = { "stylua" } } })
    end,
  },
}
