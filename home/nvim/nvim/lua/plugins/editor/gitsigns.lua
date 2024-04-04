return {
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      -- signs = {
      --   add = { text = "+" },
      --   change = { text = "~" },
      --   delete = { text = "_" },
      --   topdelete = { text = "‾" },
      --   changedelete = { text = "~" },
      -- },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
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

        -- Actions
        map("n", "<localleader>hs", gs.stage_hunk, { desc = "[h]unk [s]tage" })
        map("n", "<localleader>hr", gs.reset_hunk, { desc = "[h]unk [r]eset" })
        map("v", "<localleader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[h]unk [s]tage" })
        map("v", "<localleader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[h]unk [r]eset" })

        map("n", "<localleader>hS", gs.stage_buffer, { desc = "[h]unk [S]tage Buffer" })
        map("n", "<localleader>hR", gs.reset_buffer, { desc = "[h]unk [R]eset Buffer" })

        map("n", "<localleader>hu", gs.undo_stage_hunk, { desc = "[h]unk [u]undo Stage " })

        map("n", "<localleader>hp", gs.preview_hunk, { desc = "[h]unk [p]review" })

        map("n", "<localleader>hb", function() gs.blame_line({ full = true }) end, { desc = "Show [h]unk [b]lame line" })
        map("n", "<localleader>hB", gs.toggle_current_line_blame, { desc = "Toggle [h]unk virtual line [B]lame" })

        map("n", "<localleader>hd", gs.diffthis, { desc = "[h]unk [d]iff this" })
        map("n", "<localleader>hD", function() gs.diffthis("~") end, { desc = "[h]unk [D]iff this ~" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select [i]n [h]unk" })
        -- stylua: ignore end
      end,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = {
        relative_time = true,
      },
    },
  },
}
