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
              { win = "preview", title = "{preview}", border = "single", height = 0.65, width = 0 }, -- 0 means 100%
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
        previewers = {
          diff = {
            builtin = false,
            cmd = { "delta" },
          },
        },
        sources = {
          git_files = {
            layout = {
              preset = "ivy",
              position = "bottom",
              hidden = { "preview" },
              layout = { position = "bottom" },
            },
            matcher = { frecency = true },
            formatters = { truncate = 80 },
          },
          files = {
            layout = {
              preset = "ivy",
              position = "bottom",
              hidden = { "preview" },
              layout = { position = "bottom" },
            },
            matcher = { frecency = true },
            formatters = { truncate = 80 },
          },
          recent = {
            layout = {
              preset = "ivy",
              position = "bottom",
              hidden = { "preview" },
              layout = { position = "bottom" },
            },
            matcher = { frecency = true },
            formatters = { truncate = 80 },
          },
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
      vim.keymap.set("n", "<leader>.",function() snacks.scratch() end, {    desc = "Snacks: toggle scratch buffer" })
      vim.keymap.set("n","<leader>ss", function() snacks.scratch.select() end, { desc = "Snacks: select scratch buffer" })
      -- Pickers + Explorers
      vim.keymap.set("n","<leader>ee", function() snacks.explorer() end, { desc = "Snacks: Fil[e] [e]xplorer" })
      vim.keymap.set("n","<leader>,", function() snacks.picker.buffers({ current = true }) end, { desc = "Snacks: buffers" })
      vim.keymap.set("n","<leader>fg", function() snacks.picker.grep() end, { desc = "Snacks: grep" })
      vim.keymap.set("n","<leader>f:", function() snacks.picker.command_history() end, { desc = "Snacks: [f]ind [c]ommand history" })
      -- Find
      vim.keymap.set("n","<leader>fi", function() snacks.picker.files({filter = { cwd = true } }) end, { desc = "Snacks: [f]ind all f[i]les" })
      vim.keymap.set("n","<leader>fr", function() snacks.picker.recent({filter = { cwd = true } }) end, { desc = "Snacks: [f]ind [r]ecent files" })
      vim.keymap.set("n","<leader>ff", function() snacks.picker.git_files() end, { desc = "Snacks: [f]ind git [f]iles" })
      -- Grep
      vim.keymap.set("n","<leader>sb", function() snacks.picker.lines() end, { desc = "Snacks: [s]earch [b]uffer Lines" })
      vim.keymap.set("n","<leader>sB", function() snacks.picker.grep_buffers() end, { desc = "Snacks: grep open buffers" })
      vim.keymap.set("n","<leader>fw", function() snacks.picker.grep_word() end, { desc = "Snacks: [f]ind grep word" })
      -- search
      vim.keymap.set("n",'<leader>f"', function() snacks.picker.registers() end, { desc = 'Snacks: [f]ind registers ["]' })

      vim.keymap.set("n","<leader>f/", function() snacks.picker.search_history() end, { desc = "Snacks: [f]ind search history [/]" })
      vim.keymap.set("n","<leader>fa", function() snacks.picker.autocmds() end, { desc = "Snacks: [f]ind [a]utocmds" })
      vim.keymap.set("n","<leader>fC", function() snacks.picker.commands() end, { desc = "Snacks: [f]ind [c]ommands" })
      vim.keymap.set("n","<leader>fd", function() snacks.picker.diagnostics_buffer() end, { desc = "Snacks: [f]ind buffer [d]iagnostics" })
      vim.keymap.set("n","<leader>fD", function() snacks.picker.diagnostics() end, { desc = "Snacks: [f]ind [D]iagnostics" })
      vim.keymap.set("n","<leader>fH", function() snacks.picker.highlights() end, { desc = "Snacks: [f]ind [H]ighlights" })
      vim.keymap.set("n","<leader>fI", function() snacks.picker.icons() end, { desc = "Snacks: [f]ind [I]cons" })
      vim.keymap.set("n","<leader>fj", function() snacks.picker.jumps() end, { desc = "Snacks: [f]ind [j]umps" })

      vim.keymap.set("n","<leader>fh", function() snacks.picker.help() end, { desc = "Snacks: [f]ind [h]elp pages" })
      vim.keymap.set("n","<leader>fk", function() snacks.picker.keymaps() end, { desc = "Snacks: [f]ind [k]eymaps" })
      vim.keymap.set("n","<leader>fl", function() snacks.picker.loclist() end, { desc = "Snacks: [f]ind [l]ocation list" })
      vim.keymap.set("n","<leader>fm", function() snacks.picker.marks() end, { desc = "Snacks: [f]ind [m]arks" })
      vim.keymap.set("n","<leader>fp", function() snacks.picker.lazy() end, { desc = "Snacks: [f]ind lazy [p]luginSpec" })
      vim.keymap.set("n","<leader>fq", function() snacks.picker.qflist() end, { desc = "Snacks: [f]ind [q]uickfix list" })
      vim.keymap.set("n","<leader>sR", function() snacks.picker.resume() end, { desc = "Snacks: [R]esume" })
      vim.keymap.set("n","<leader>fu", function() snacks.picker.undo() end, { desc = "Snacks: [f]ind [u]ndo history" })
      -- git
      vim.keymap.set("n","<leader>Gb", function() snacks.picker.git_branches() end, { desc = "Snacks: [G]it [b]ranches" })
      vim.keymap.set("n","<leader>Gl", function() snacks.picker.git_log() end, { desc = "Snacks: [G]it [l]og" })
      vim.keymap.set("n","<leader>GL", function() snacks.picker.git_log_line() end, { desc = "Snacks: [G]it log [L]ine" })
      vim.keymap.set("n","<leader>Gs", function() snacks.picker.git_status() end, { desc = "Snacks: [G]it [s]tatus" })
      vim.keymap.set("n","<leader>GS", function() snacks.picker.git_stash() end, { desc = "Snacks: [G]it [S]tash" })
      vim.keymap.set("n","<leader>Gd", function() snacks.picker.git_diff() end, { desc = "Snacks: [G]it [d]iff" })
      vim.keymap.set("n","<leader>Gf", function() snacks.picker.git_log_file() end, { desc = "Snacks: [G]it log [f]ile" })
      vim.keymap.set({ "n", "v" },"<leader>GB", function() snacks.gitbrowse.open() end, { desc = "Snacks: [G]it [B]rowse commit" })
      -- LSP
      -- TODO: Adjust after nvim 0.11 has been released?
      vim.keymap.set("n","gd", function() snacks.picker.lsp_definitions() end, { desc = "Snacks: goto definition" })
      -- vim.keymap.set("n","gD", function() snacks.picker.lsp_declarations() end, { desc = "[Snacks] Goto Declaration" })
      vim.keymap.set("n","grr", function() snacks.picker.lsp_references() end, { desc = "Snacks: references" })
      vim.keymap.set("n","gi", function() snacks.picker.lsp_implementations() end, { desc = "Snacks: goto implementation" })
      vim.keymap.set("n","gt", function() snacks.picker.lsp_type_definitions() end, { desc = "Snacks: goto t[y]pe definition" })
      vim.keymap.set("n","gs", function() snacks.picker.lsp_symbols() end, { desc = "Snacks: LSP symbols" })
      vim.keymap.set("n","gS", function() snacks.picker.lsp_workspace_symbols() end, { desc = "Snacks: LSP workspace symbols" })
      -- stylua: ignore end

      -- Notify LSP when file is moved in Oil.nvim
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
