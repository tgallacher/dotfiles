return {
  { -- highlight+give keymaps for git merge conflict marker sections
    -- Format of merge:
    -- ```
    -- <<<<<<< HEAD
    -- ours
    -- =======
    -- theirs
    -- >>>>>>> deadbeef0123
    -- ```
    --
    -- Which map to the following acceptance keymaps
    --  ct - accept "theirs"
    --  co - accept "ours"
    --  cb - accept "both"
    --  cB - accept "both" but reverse order
    --  cn - discard both changes
    --
    "rhysd/conflict-marker.vim",
    init = function()
      -- Set the conflict marker highlight group to an empty string
      vim.g.conflict_marker_highlight_group = ""
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = "^<<<<<<< .*$"
      vim.g.conflict_marker_end = "^>>>>>>> .*$"
      -- FIXME: adjust the colours so they match the current colorscheme
      -- see https://github.com/rhysd/conflict-marker.vim/issues/17
      -- Highlight settings
      vim.cmd([[
        highlight ConflictMarkerBegin guifg=#54546D
        highlight ConflictMarkerOurs guibg=#363646
        highlight ConflictMarkerSeparator guifg=#54546D
        highlight ConflictMarkerTheirs guibg=#2B3328
        highlight ConflictMarkerEnd guifg=#54546D
      ]])
    end,
  },

  { -- Embedded Git commands inside neovim
    "tpope/vim-fugitive",
    init = function()
      vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[g]it [s]tatus" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "[g]it [p]ush" })
      vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "[g]it [P]ull" })
      vim.keymap.set("n", "<leader>gf", ":Git fetch<CR>", { desc = "[g]it [f]etch" })
      vim.keymap.set("n", "<leader>gcb", ":Git checkout -b ", { desc = "[g]it [c]heckout [b]ranch" })
      vim.keymap.set("n", "<leader>gco", ":Git checkout ", { desc = "[g]it [c]heck[o]ut" })
      vim.keymap.set("n", "<leader>grbi", ":Git rebase --interactive ", { desc = "[g]it [r]e[b]ase [i]nteractive" })
      vim.keymap.set("n", "<leader>grbn", ":Git rebase ", { desc = "[g]it [r]e[b]ase [n]on-interactive" })
      vim.keymap.set("n", "<leader>grbc", ":Git rebase --continue<CR>", { desc = "[g]it [r]e[b]ase [c]ontinue" })
      vim.keymap.set("n", "<leader>grba", ":Git rebase --abort<CR>", { desc = "[g]it [r]e[b]ase [a]bort" })
      vim.keymap.set(
        "n",
        "<leader>gl",
        ":Git log -30 --abbrev-commit --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'<cr>",
        { desc = "[g]it [l]og (30 commits)" }
      )

      vim.keymap.set("n", "<localleader>gb", ":Git blame<CR>", { desc = "[g]it [b][b]lame" })
      vim.keymap.set("n", "<localleader>gd", ":Gvdiffsplit<CR>", { desc = "[g]it [D]iff" })
      -- vim.keymap.set("n", "<localleader>gcb", function()
      --   local filepath = vim.api.nvim_buf_get_name(0)
      --   local handle = io.popen("git log --abbrev-commit --no-decorate --pretty='format:%cs: %h -%d %s (%cr) <%an>' " .. filepath)
      --   if not handle then; return end
      --
      --   local result = handle:read("*a") -- Read all output
      --   handle:close()
      -- end, { desc = "[g]it [c]ommits [b]uffer" })
    end,
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      numhl = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- stylua: ignore start
        -- Navigation
        map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })
        map("n", "]H", function() gs.nav_hunk("last") end, { desc = "Last Hunk" })
        map("n", "[H", function() gs.nav_hunk("first") end, { desc = "First Hunk" })

        -- Actions
        map("n", "<localleader>hs", gs.stage_hunk, { desc = "[h]unk [s]tage" })
        map("v", "<localleader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[h]unk [s]tage" })

        map("n", "<localleader>hr", gs.reset_hunk, { desc = "[h]unk [r]eset" })
        map("v", "<localleader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[h]unk [r]eset" })

        map("n", "<localleader>hS", gs.stage_buffer, { desc = "[h]unk [S]tage Buffer" })
        map("n", "<localleader>hR", gs.reset_buffer, { desc = "[h]unk [R]eset Buffer" })

        map("n", "<localleader>hu", gs.undo_stage_hunk, { desc = "[h]unk [u]ndo Stage " })
        map("n", "<localleader>hp", gs.preview_hunk, { desc = "[h]unk [p]review" })

        map("n", "<localleader>hb", function() gs.blame_line({ full = true }) end, { desc = "Show [h]unk [b]lame line" })
        map("n", "<localleader>hB", gs.toggle_current_line_blame, { desc = "Toggle [h]unk virtual line [B]lame" })

        map("n", "<localleader>hd", gs.diffthis, { desc = "[h]unk [d]iff this" })
        -- split diff view
        map("n", "<localleader>hD", function() gs.diffthis() end, { desc = "[h]unk [D]iff this ~" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select [i]n [h]unk" })
        -- stylua: ignore end
      end,
    },
  },
}
