return {
  -- manage lists
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      {
        "<leader>tr",
        function() require("telescope.builtin").resume() end,
        desc = "Resume previous telescope w/state",
      },
      {
        "<leader>ts",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find string (root dir)",
      },
      {
        "<leader>tS",
        function() require("telescope.builtin").live_grep({ grep_open_files = true }) end,
        desc = "Find string (open buffers)",
      },
      {
        "<leader>fF",
        function() require("telescope.builtin").find_files() end,
        desc = "Find files",
      },
      {
        "<leader>fh",
        function() require("telescope.builtin").find_files({ hidden = true }) end,
        desc = "Find files (hidden)",
      },
      {
        "<leader>fi",
        function() require("telescope.builtin").find_files({ no_ignore = true }) end,
        desc = "Find files (ignored)",
      },
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
        desc = "Find files (hidden,ignored)",
      },
      {
        "<leader>fs",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Find string inside current buffer",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").git_files({
            show_untracked = true,
          })
        end,
        desc = "Find git files",
      },
      {
        "<leader>fr",
        function() require("telescope.builtin").oldfiles({ only_cwd = true }) end,
        desc = "Show recently opened files",
      },
      {
        "<leader>gc",
        function() require("telescope.builtin").git_bcommits() end,
        desc = "Show git commits for current buffer",
      },
      {
        "<leader>gs",
        function() require("telescope.builtin").git_status() end,
        desc = "Show git status",
      },
      {
        "<leader>tsh",
        function() require("telescope.builtin").search_history() end,
        desc = "Show search history",
      },
      {
        "<leader>,",
        function() require("telescope.builtin").buffers({ ignore_current_buffer = true, sort_mru = true }) end,
        desc = "Show open buffers",
      },
      {
        "<leader>th",
        function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
        desc = "Show available colorschemes",
      },
      {
        "<leader>sp",
        function() require("telescope.builtin").spell_suggest() end,
        desc = "Show spelling suggestions for word under cursor",
      },
      { -- FIXME: clash with Tmux
        "<localleader>s",
        function() require("telescope.builtin").treesitter() end,
        desc = "Show symbols in buffer",
      },
      {
        "<localleader>sd",
        function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
        desc = "Document diagnostics",
      },
      {
        "<localleader>sD",
        function() require("telescope.builtin").diagnostics() end,
        desc = "Workspace diagnostics",
      },
      -- {
      --   "<leader>sw",
      --   function() require("telescope.builtin").grep_string() end,
      --   mode = "v",
      --   desc = "Find selection (root dir)",
      -- },
      {
        "<localleader>gts",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<localleader>gtS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = {
      pickers = {
        live_grep = {
          additional_args = function() return { "--hidden" } end,
        },
      },
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        file_ignore_patterns = { "^.git", "node_modules" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
          i = {
            ["<C-t>"] = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end,
            ["<A-t>"] = function(...) return require("trouble.providers.telescope").open_selected_with_trouble(...) end,
            -- ["<a-i>"] = function()
            --   local action_state = require("telescope.actions.state")
            --   local line = action_state.get_current_line()
            --   Util.telescope("find_files", { no_ignore = true, default_text = line })()
            -- end,
            -- ["<a-h>"] = function()
            --   local action_state = require("telescope.actions.state")
            --   local line = action_state.get_current_line()
            --   Util.telescope("find_files", { hidden = true, default_text = line })()
            -- end,
            ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
            ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
            ["<C-f>"] = function(...) return require("telescope.actions").preview_scrolling_down(...) end,
            ["<C-b>"] = function(...) return require("telescope.actions").preview_scrolling_up(...) end,
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
            ["<C-c>"] = function(...) return require("telescope.actions").close(...) end,
          },
          n = {
            ["q"] = function(...) return require("telescope.actions").close(...) end,
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
