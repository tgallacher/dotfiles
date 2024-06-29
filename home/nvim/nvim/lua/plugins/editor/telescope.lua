return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    -- event = "VimEnter",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        -- stylua: ignore
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "^.git", "node_modules", "__pycache__", ".venv" },
          path_display = { shorten = { len = 4, exclude = { -2, -1 } } },
          mappings = {
            i = {
              -- stylua: ignore start
              ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
              ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              -- stylua: ignore end
            },
          },
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            horizontal = { preview_cutoff = 80, preview_width = 0.45 },
            vertical = { mirror = true, preview_cutoff = 25 },
            prompt_position = "top",
            width = 0.87,
            height = 0.80,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      -- stylua: ignore start
      vim.keymap.set("n", "<leader>f?", builtin.help_tags, { desc = "[f]ind Help" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[f]ind [k]eymaps" })
      vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ hidden = true, no_ignore = false }) end, { desc = "[f]ind [f]iles" })
      vim.keymap.set("n", "<leader>fi", function() builtin.find_files({ hidden = true, no_ignore = true }) end, { desc = "[f]ind [i]gnored files" })
      vim.keymap.set("n", "<leader>fr", function() builtin.oldfiles({ only_cwd = true }) end, { desc = "[f]ind [r]ecent Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[f]ind by live [g]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[f]ind [d]iagnostics" })

      vim.keymap.set("n", "<leader>rt", builtin.resume, { desc = "[r]esume [t]elescope" })
      vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "[,] show open buffers" })

      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[g]it [s]tatus" })
      vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "[g]it s[t]ash" })
      vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "[g]it [c]ommits (buffer)" })

      vim.keymap.set("n", "<localleader>fw", builtin.grep_string, { desc = "[f]ind [w]ord under cursor" })
      vim.keymap.set("n", "<localleader>fg", function() builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep (Open Buffers)" }) end, { desc = "[f]ind by live [g]rep open buffers" })
      -- stylua: ignore end
      vim.keymap.set("n", "<localleader>fs", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
      end, { desc = "[f]uzzily [s]earch in current buffer" })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[s]earch [n]eovim files" })
    end,
  },
}
