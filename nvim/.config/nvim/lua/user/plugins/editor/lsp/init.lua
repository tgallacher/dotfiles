local icons = require("user.config.icons")

return {
  -- LSP package manager
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      -- install some base tooling
      ensure_installed = {
        "taplo", -- toml
        "shfmt",
        "shellcheck",
      },
      ui = {
        border = "none",
        icons = {
          package_installed = "",
          package_pending = "󰇘",
          package_uninstalled = "",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local msnr = require("mason-registry")

      local ensure_installed = function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = msnr.get_package(tool)

          if not p:is_installed() then p:install() end
        end
      end

      if msnr.refresh then
        msnr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      -- { "j-hui/fidget.nvim",       config = true,   tag = "legacy" },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      servers = {},
      setup = {},
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(plugin, opts)
      -- process merged lspconfig LazyVim specs through the custom setup func
      require("user.plugins.editor.lsp.servers").setup(plugin, opts)
    end,
  },

  -- LSP UI
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
      },
      lightbulb = { virtual_text = false },
      ui = {
        code_action = icons.ui.Lightbulb,
        expand = icons.ui.ArrowRight,
        collapse = icons.ui.ArrowDown,
        colors = {
          normal_bg = "#022746",
        },
      },
      floaterm = {
        width = 0.9,
        height = 0.9,
      },
    },
    config = true,
    -- keys = {
    -- 	{ "<A-d>", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" } },
    -- },
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local nullls = require("null-ls")

      return {
        debug = false,
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        -- Configure sources which are not installable via `mason-null-ls`
        sources = {
          nullls.builtins.formatting.shfmt,
          nullls.builtins.diagnostics.shellcheck,
          nullls.builtins.code_actions.shellcheck,
        },
      }
    end,
    keys = {
      {
        -- TODO: how does this compare to plugins.editor.lsp.format#format?
        "<localleader>fm",
        function() vim.lsp.buf.format({ async = true }) end,
        mode = { "n", "v" },
        { desc = "Format" },
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      ensure_installed = nil,
      automatic_installation = true,
      automatic_setup = false,
      -- handlers = {}, -- auto register all `ensure_installed` plugins with null-ls
    },
  },
}
