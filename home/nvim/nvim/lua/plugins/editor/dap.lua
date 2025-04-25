local icons = {
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
}

return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      -- stylua: ignore start
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      -- stylua: ignore end
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      -- stylua: ignore start
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
      -- stylua: ignore end
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "DAP: Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: Run/Continue" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "DAP: Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "DAP: Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "DAP: Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "DAP: Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "DAP: Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "DAP: Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "DAP: Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP: Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "DAP: Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "DAP: Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "DAP: Widgets" },
      -- stylua: ignore end
    },
    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      -- require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))

      -- -- FIXME: What does this do? Source? Possibly LazyVim?
      -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      -- for name, sign in pairs(icons.dap) do
      --   sign = type(sign) == "table" and sign or { sign }
      --   vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
      -- end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")

      ---@diagnostic disable-next-line: duplicate-set-field
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    -- config = function() end,
  },
}
