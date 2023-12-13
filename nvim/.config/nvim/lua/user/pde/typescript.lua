if not require("user.config.pde").lsp.typescript then return {} end

-- TODO: Add config
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "graphql",
        "prisma",
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "prettierd",
        -- "typescript-language-server",
        "js-debug-adapter",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      -- {
      --   "folke/neoconf.nvim",
      --   cmd = "Neoconf",
      --   config = true,
      -- },
    },
    opts = {},
    config = function(_, opts)
      local lsputils = require("user.plugins.editor.lsp.utils")

      lsputils.on_attach(function(client, bufnr)
        if client.name == "tsserver" then
          -- stylua: ignore start
          vim.keymap.set("n", "<localleader>lo", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
          vim.keymap.set("n", "<localleader>lO", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
          vim.keymap.set("n", "<localleader>lu", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
          vim.keymap.set("n", "<localleader>lz", "<cmd>TSToolsGoToSourceDefinition<cr>", { buffer = bufnr, desc = "Go To Source Definition" })
          vim.keymap.set("n", "<localleader>lR", "<cmd>TSToolsRemoveUnusedImports<cr>", { buffer = bufnr, desc = "Removed Unused Imports" })
          vim.keymap.set("n", "<localleader>lF", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
          vim.keymap.set("n", "<localleader>lA", "<cmd>TSToolsAddMissingImports<cr>", { buffer = bufnr, desc = "Add Missing Imports" })
          -- stylua: ignore end
        end
      end)

      require("typescript-tools").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "pmizio/typescript-tools.nvim" },
    opts = {
      servers = {
        prismals = {},
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(event)
              local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
              if client then
                local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then vim.cmd("EslintFixAll") end
              end
            end,
          })
        end,
      },
    },
  },

  -- {
  --   "mfussenegger/nvim-dap",
  --   opts = {
  --     setup = {
  --       vscode_js_debug = function()
  --         local function get_js_debug()
  --           local install_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --           return install_path .. "/js-debug/src/dapDebugServer.js"
  --         end

  --         for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } do
  --           require("dap").adapters[adapter] = {
  --             type = "server",
  --             host = "localhost",
  --             port = "${port}",
  --             executable = {
  --               command = "node",
  --               args = {
  --                 get_js_debug(),
  --                 "${port}",
  --               },
  --             },
  --           }
  --         end

  --         for _, language in ipairs { "typescript", "javascript" } do
  --           require("dap").configurations[language] = {
  --             {
  --               type = "pwa-node",
  --               request = "launch",
  --               name = "Launch file",
  --               program = "${file}",
  --               cwd = "${workspaceFolder}",
  --             },
  --             {
  --               type = "pwa-node",
  --               request = "attach",
  --               name = "Attach",
  --               processId = require("dap.utils").pick_process,
  --               cwd = "${workspaceFolder}",
  --             },
  --             {
  --               type = "pwa-node",
  --               request = "launch",
  --               name = "Debug Jest Tests",
  --               -- trace = true, -- include debugger info
  --               runtimeExecutable = "node",
  --               runtimeArgs = {
  --                 "./node_modules/jest/bin/jest.js",
  --                 "--runInBand",
  --               },
  --               rootPath = "${workspaceFolder}",
  --               cwd = "${workspaceFolder}",
  --               console = "integratedTerminal",
  --               internalConsoleOptions = "neverOpen",
  --             },
  --             {
  --               type = "pwa-chrome",
  --               name = "Attach - Remote Debugging",
  --               request = "attach",
  --               program = "${file}",
  --               cwd = vim.fn.getcwd(),
  --               sourceMaps = true,
  --               protocol = "inspector",
  --               port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
  --               webRoot = "${workspaceFolder}",
  --             },
  --             {
  --               type = "pwa-chrome",
  --               name = "Launch Chrome",
  --               request = "launch",
  --               url = "http://localhost:5173", -- TODO: This is for Vite. Change it to the framework you use
  --               webRoot = "${workspaceFolder}",
  --               userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
  --             },
  --           }
  --         end

  --         for _, language in ipairs { "typescriptreact", "javascriptreact" } do
  --           require("dap").configurations[language] = {
  --             {
  --               type = "pwa-chrome",
  --               name = "Attach - Remote Debugging",
  --               request = "attach",
  --               program = "${file}",
  --               cwd = vim.fn.getcwd(),
  --               sourceMaps = true,
  --               protocol = "inspector",
  --               port = 9222, -- Start Chrome google-chrome --remote-debugging-port=9222
  --               webRoot = "${workspaceFolder}",
  --             },
  --             {
  --               type = "pwa-chrome",
  --               name = "Launch Chrome",
  --               request = "launch",
  --               url = "http://localhost:5173", -- TODO: This is for Vite. Change it to the framework you use
  --               webRoot = "${workspaceFolder}",
  --               userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
  --             },
  --           }
  --         end
  --       end,
  --     },
  --   },
  -- },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters or {}, {
        require("neotest-jest"),
      })

      return opts
    end,
  },
}
