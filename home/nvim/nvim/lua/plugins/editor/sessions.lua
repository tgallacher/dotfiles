return {
  { -- save nvim session and restore
    -- NOTE: saving is automatic, but reloading is manual
    "rmagatti/auto-session",
    config = function()
      local auto_session = require("auto-session")

      auto_session.setup({
        auto_restore = false, -- let us manually restore this
        suppressed_dirs = { "~/", "~/Code/", "~/Downloads", "~/Documents", "~/Desktop/" },
      })

      vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "[W]orkspace session [R]estore for cwd" }) -- restore last workspace session for current directory
      vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "[W]orkspace [S]ave session for cwd" }) -- save workspace session for current working directory
    end,
    init = function()
      -- ensure's filetype, highlighting plugins work on restore
      vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
