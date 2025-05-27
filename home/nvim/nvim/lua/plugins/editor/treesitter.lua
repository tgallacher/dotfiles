return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      ensure_installed = {}, -- languages to install; NOTE: we separate this out into the PDE dir
      auto_install = true, -- Auto-install languages that are not installed
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<C-s>",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@comment.outer",
          ["ic"] = "@comment.inner",
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            ["]c"] = "@comment.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
            ["]A"] = "@parameter.inner",
            ["]C"] = "@comment.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[c"] = "@comment.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
            ["[A"] = "@parameter.inner",
            ["[C"] = "@comment.outer",
          },
        },
        lsp_interop = {
          enable = true,
          border = "single",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<localleader>df"] = "@function.outer",
            ["<localleader>dF"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<localleader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<localleader>A"] = "@parameter.inner",
          },
        },
      },
    },
    init = function()
      -- stylua: ignore
      vim.keymap.set("n", "[c", function() require("treesitter-context").go_to_context(vim.v.count1) end, { silent = true })

      -- FIXME: this breaks normal ; and ,
      -- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      -- -- ensure ; goes forward and , goes backward regardless of the last direction
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end,
  },
}
