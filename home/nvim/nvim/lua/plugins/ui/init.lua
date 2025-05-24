return {
  { -- Toggle maximising split window
    "szw/vim-maximizer",
    event = "InsertEnter",
    keys = {
      { "<leader>sm", ":MaximizerToggle<cr>", { desc = "[s]plit [m]aximise window toggle" } },
    },
  },

  { -- Peek buffer when entering line number :<number>
    "nacro90/numb.nvim",
    event = "InsertEnter",
    config = true,
  },

  { -- visualise hex codes
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- TODO: This is a todo
  -- TODO(scope): This is a todo
  -- TODO (scope): This is a todo
  -- WARN(tomg): This is a warning
  -- FIXME: This is a fixme
  -- todo: This is a lowercase todo

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = { "BufNewFile", "BufReadPre" },
    priority = 0,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      -- FIXME: make case-insensitive, `\c` flag doesn't seem to work below
      highlight = {
        -- vimgrep regex, supporting the pattern TODO(name):
        pattern = [[.*<((KEYWORDS)\s*%(\(.{-1,}\))?):\c]],
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--ignore-case",
        },
        -- ripgrep regex, supporting the pattern TODO(name):
        pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
      },
    },
    config = function(_, opts)
      local todo_comments = require("todo-comments")
      todo_comments.setup(opts)

      -- stylua: ignore start
      vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next [T]odo comment" })
      vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Prev [T]odo comment" })

      local snacks = require("snacks")
      vim.keymap.set("n", "<leader>st", function () snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, { desc = "Show TODO/FIX/FIXME" })
      vim.keymap.set("n", "<leader>sT", function() snacks.picker.todo_comments() end, { desc = "Show all Todo comments" })
      -- stylua: ignore end
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    -- prevent https://github.com/folke/todo-comments.nvim/issues/133
    event = "VimEnter",
    config = function() -- This function runs AFTER loading
      local whichkey = require("which-key")

      whichkey.setup()
      whichkey.add({
        { "<leader>f", group = "[f]ind" },
        { "<leader>w", group = "[w]orkspace" },
        { "<leader>t", group = "[t]rouble" },
        { "<leader>h", group = "[h]unk" },
        { "<leader>e", group = "NvimTre[e]" },
        { "<leader>b", group = "[b]uffers" },
        { "<leader>s", group = "[s]plits" },
        { "<leader>z", group = "[z]en" },
        { "<leader>c", group = "[c]hatgpt" },
        { "<leader>g", group = "[g]it" },

        { "<localleader>q", group = "[q]uickfix" },
        { "<localleader>d", group = "[d]iagnostic" },
      })

      -- FIXME: fix bug: https://github.com/folke/which-key.nvim/issues/476
      vim.api.nvim_create_autocmd("FileType", {
        desc = "Fix which-key trigger on `localleader`",
        group = vim.api.nvim_create_augroup("whickey_localleader", { clear = true }),
        pattern = "*",
        callback = function()
          -- stylua: ignore
          -- WARN: magic string here for `localleader`; how to make this dynamic
          vim.keymap.set("n", "<localleader>", function() whichkey.show("\\") end, { buffer = true })
        end,
      })
    end,
  },

  { -- improve some vim ui elements
    "stevearc/dressing.nvim",
    -- prevent https://github.com/folke/todo-comments.nvim/issues/133
    event = "VimEnter",
    opts = {
      input = {
        -- relative = "editor",
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<C-k>"] = "HistoryPrev",
            ["<C-j>"] = "HistoryNext",
          },
        },
      },
    },
  },

  {
    "j-hui/fidget.nvim",
    event = { "BufEnter" },
    opts = {
      notification = {
        window = {
          winblend = 0, -- drop background
        },
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufEnter",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      local ufo = require("ufo")

      -- vim.o.foldmethod = "manual"
      vim.o.foldcolumn = "0" -- "0" disable the left most column
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = -1
      vim.o.foldenable = true

      ufo.setup({
        close_fold_kinds_for_ft = {
          default = { "imports", "comment", "region" },
        },
        open_fold_hl_timeout = 400,
        enable_get_fold_virt_text = true,
        preview = {
          win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
        provider_selector = function()
          -- use treesitter for fold and not lsp
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", ufo.openAllFolds)
      vim.keymap.set("n", "zM", ufo.closeAllFolds)
      vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
      vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set("n", "zk", function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end,
  },
}
