return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "andythigpen/nvim-coverage", -- test coverage display
    },
    opts = {
      adapters = {},
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 1,
      },
      running = {
        -- Run tests concurrently when an adapter provides multiple commands to run.
        concurrent = true,
      },
      summary = {
        -- Enable/disable animation of icons.
        animated = false,
      },
    },
    config = function(_, opts)
      require("neotest").setup(opts)
    end,
    -- init = function()
    --   local nt = require("neotest")
    --
    --   -- stylua: ignore start
    --   vim.keymap.set("n", "<localleader>ts", nt.summary.toggle, { desc = "Toggle [t]est [s]ummary" })
    --
    --
    --   vim.keymap.set("n", "[n", function() nt.jump.prev({ status = "failed" }) end, { desc = "Jump to prev failed test" })
    --   vim.keymap.set("n", "]n", function() nt.jump.next({ status = "failed" }) end, { desc = "Jump to prev failed test" })
    --
    --   vim.keymap.set("n", "<localleader>tx", nt.run.stop, { desc = "[t]est stop run [x]" })
    --   vim.keymap.set("n", "<localleader>tr", nt.run.run, { desc = "[t]est [r]un nearest test" })
    --   vim.keymap.set("n", "<localleader>tf", function() nt.run.run(vim.fn.expand("%")) end, { desc = "[t]est [f]ile" })
    --   -- stylua: ignore end
    -- end,
    keys = {
      -- stylua: ignore start
      { "[n", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Jump to prev failed test" },
      { "]n", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Jump to next failed test" },

      { "<localleader>ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
      { "<localleader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
      { "<localleader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
      { "<localleader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
      { "<localleader>tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
      { "<localleader>tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
      { "<localleader>ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
      { "<localleader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
      { "<localleader>tO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
      { "<localleader>tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
      { "<localleader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<localleader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = false }) end, desc = "Debug current file" },
      -- stylua: ignore end
    },
  },
}
