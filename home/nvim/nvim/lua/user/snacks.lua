return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      styles = {
        scratch = {
          border = "double",
          relative = "editor",
        },
      },
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = true, replace_netrw = true },
      image = { enabled = true },
      indent = { enabled = true },
      input = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        enabled = true,
        layouts = {
          default = {
            hidden = { "preview" },
            layout = {
              box = "vertical",
              width = 0.8,
              min_width = 120,
              height = 0.8,
              {
                box = "vertical",
                border = "single",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "single", width = 0 },
            },
          },
          vertical = {
            hidden = { "preview" },
            layout = {
              layout = { height = 0.8 },
            },
          },
        },
        -- layout = {
        --   -- preview = false,
        --   -- layout = { position = "top", height = 0.4, border = "double" },
        --   -- { win = "input", border = "single" },
        -- },
        sources = {
          explorer = {
            layout = {
              preset = "sidebar",
              preview = "main", -- show preview in main winow
              hidden = { "preview" }, -- hide preview on open
              layout = { position = "right" },
            },
          },
          lines = {
            layout = {
              preset = "ivy",
              preview = "main",
              layout = { height = 10 },
            },
          },
          buffers = {
            layout = { preset = "vertical" },
          },
          -- select = {
          --   layout = { layout = { position = "float" } },
          -- },
          git_branches = {
            layout = {
              preset = "vertical",
              layout = { position = "float", height = 0.8, width = 0.8 },
            },
          },
        },
      },
    },
    init = function()
      vim.g.snacks_animate = false

      local snacks = require("snacks")

      snacks.dim.disable()
      snacks.input.disable()
      snacks.scroll.disable()

      -- b: yyp@a
      -- a: 02jyiq2k0s2inq02jy2ina2k0s3ina02j$yilq2k$silq2j0dd2k

      -- stylua: ignore start
      vim.keymap.set("n", "<leader>.",function() snacks.scratch() end, {    desc = "[Snacks] Toggle Scratch Buffer" })
      vim.keymap.set("n","<leader>ss", function() snacks.scratch.select() end, { desc = "[Snacks] Select Scratch Buffer" })
      -- Pickers + Explorers
      vim.keymap.set("n","<leader>ee", function() snacks.explorer() end, { desc = "[Snacks] File explorer" })
      vim.keymap.set("n","<leader>,", function() snacks.picker.buffers({ current = true }) end, { desc = "[Snacks] Buffers" })
      vim.keymap.set("n","<leader>/", function() snacks.picker.grep() end, { desc = "[Snacks] Grep" })
      vim.keymap.set("n","<leader>:", function() snacks.picker.command_history() end, { desc = "[Snacks] Command History" })
      -- Find
      vim.keymap.set("n","<leader>ff", function() snacks.picker.files({filter = { cwd = true } }) end, { desc = "[Snacks] Find Files" })
      vim.keymap.set("n","<leader>fr", function() snacks.picker.recent({filter = { cwd = true } }) end, { desc = "[Snacks] Recent" })
      vim.keymap.set("n","<leader>fg", function() snacks.picker.git_files() end, { desc = "[Snacks] Find Git Files" })
      -- Grep
      vim.keymap.set("n","<leader>sb", function() snacks.picker.lines() end, { desc = "[Snacks] [s]earch [b]uffer Lines" })
      vim.keymap.set("n","<leader>sB", function() snacks.picker.grep_buffers() end, { desc = "[Snacks] Grep Open Buffers" })
      vim.keymap.set("n","<leader>fw", function() snacks.picker.grep_word() end, { desc = "[Snacks] [f]ind Grep word" })
      -- search
      vim.keymap.set("n","<leader>fR", function() snacks.picker.registers() end, { desc = "[Snacks] Registers" })

      vim.keymap.set("n","<leader>s/", function() snacks.picker.search_history() end, { desc = "[Snacks] Search History" })
      vim.keymap.set("n","<leader>sa", function() snacks.picker.autocmds() end, { desc = "[Snacks] Autocmds" })
      vim.keymap.set("n","<leader>sC", function() snacks.picker.commands() end, { desc = "[Snacks] Commands" })
      vim.keymap.set("n","<leader>sD", function() snacks.picker.diagnostics() end, { desc = "[Snacks] Diagnostics" })
      vim.keymap.set("n","<leader>sd", function() snacks.picker.diagnostics_buffer() end, { desc = "[Snacks] Buffer Diagnostics" })
      vim.keymap.set("n","<leader>sH", function() snacks.picker.highlights() end, { desc = "[Snacks] Highlights" })
      vim.keymap.set("n","<leader>si", function() snacks.picker.icons() end, { desc = "[Snacks] Icons" })
      vim.keymap.set("n","<leader>sj", function() snacks.picker.jumps() end, { desc = "[Snacks] Jumps" })

      vim.keymap.set("n","<leader>fh", function() snacks.picker.help() end, { desc = "[Snacks] Help Pages" })
      vim.keymap.set("n","<leader>sk", function() snacks.picker.keymaps() end, { desc = "[Snacks] Keymaps" })
      vim.keymap.set("n","<leader>sl", function() snacks.picker.loclist() end, { desc = "[Snacks] Location List" })
      vim.keymap.set("n","<leader>fm", function() snacks.picker.marks() end, { desc = "[Snacks] Marks" })
      vim.keymap.set("n","<leader>sp", function() snacks.picker.lazy() end, { desc = "[Snacks] Search for Plugin Spec" })
      vim.keymap.set("n","<leader>sq", function() snacks.picker.qflist() end, { desc = "[Snacks] Quickfix List" })
      vim.keymap.set("n","<leader>sR", function() snacks.picker.resume() end, { desc = "[Snacks] Resume" })
      vim.keymap.set("n","<leader>su", function() snacks.picker.undo() end, { desc = "[Snacks] Undo History" })
      -- git
      vim.keymap.set("n","<leader>Gb", function() snacks.picker.git_branches() end, { desc = "[Snacks] Git Branches" })
      vim.keymap.set("n","<leader>Gl", function() snacks.picker.git_log() end, { desc = "[Snacks] Git Log" })
      vim.keymap.set("n","<leader>GL", function() snacks.picker.git_log_line() end, { desc = "[Snacks] Git Log Line" })
      vim.keymap.set("n","<leader>Gs", function() snacks.picker.git_status() end, { desc = "[Snacks] Git Status" })
      vim.keymap.set("n","<leader>GS", function() snacks.picker.git_stash() end, { desc = "[Snacks] Git Stash" })
      vim.keymap.set("n","<leader>Gd", function() snacks.picker.git_diff() end, { desc = "[Snacks] Git Log File" })
      vim.keymap.set("n","<leader>Gf", function() snacks.picker.git_log_file() end, { desc = "[Snacks] Git Log File" })
      vim.keymap.set({ "n", "v" },"<leader>GB", function() snacks.gitbrowse.open() end, { desc = "[Snacks] Open git commit" })
      -- LSP
      -- TODO: Adjust after nvim 0.11 has been released?
      vim.keymap.set("n","gd", function() snacks.picker.lsp_definitions() end, { desc = "[Snacks] Goto Definition" })
      -- vim.keymap.set("n","gD", function() snacks.picker.lsp_declarations() end, { desc = "[Snacks] Goto Declaration" })
      vim.keymap.set("n","grr", function() snacks.picker.lsp_references() end, { desc = "[Snacks] References" })
      vim.keymap.set("n","gi", function() snacks.picker.lsp_implementations() end, { desc = "[Snacks] Goto Implementation" })
      vim.keymap.set("n","gt", function() snacks.picker.lsp_type_definitions() end, { desc = "[Snacks] Goto T[y]pe Definition" })
      vim.keymap.set("n","gs", function() snacks.picker.lsp_symbols() end, { desc = "[Snacks] LSP Symbols" })
      vim.keymap.set("n","gS", function() snacks.picker.lsp_workspace_symbols() end, { desc = "[Snacks] LSP Workspace Symbols" })

      -- -- Buffers
      -- vim.keymap.set("n","<leader>bc", function() snacks.bufdelete.delete() end, { desc = "[Snacks] Close current buffer" })
      -- vim.keymap.set("n","<leader>bC", function() snacks.bufdelete.other() end, { desc = "[Snacks] Close all other buffers" })

      -- stylua: ignore end

      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>B", ":e#<cr>", desc = "Open last closed [B]uffer" },
      {"<leader>bc", function() require("snacks").bufdelete.delete() end, desc = "[Snacks] Close current buffer",},
      {"<leader>bC", function() require("snacks").bufdelete.other() end, desc = "[Snacks] Close all other buffers",},
      -- stylua: ignore end
    },
  },
}
