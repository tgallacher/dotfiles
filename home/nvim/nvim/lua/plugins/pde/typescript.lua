-- FIXME: Update to nvim 0.11 setup when this LSP is required
local action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

local servers = {
  -- eslint = {
  --   settings = {
  --     useFlatConfig = false,
  --     experimental = {
  --       useFlatConfig = false,
  --     },
  --   },
  -- },
  ts_ls = { enabled = true },
  vtsls = {
    enabled = false,
    -- explicitly add default filetypes, so that we can extend
    -- them in related extras
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
    keys = {
      {
        "gD",
        function()
          local params = vim.lsp.util.make_position_params()
          -- vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
          require("trouble").open({
            mode = "lsp_command",
            params = {
              command = "typescript.goToSourceDefinition",
              arguments = { params.textDocument.uri, params.position },
            },
          })
        end,
        desc = "Goto Source Definition",
      },
      {
        "gR",
        function()
          require("trouble").open({
            mode = "lsp_command",
            params = {
              command = "typescript.findAllFileReferences",
              arguments = { vim.uri_from_bufnr(0) },
              open = true,
            },
          })
        end,
        desc = "File References",
      },
      {
        "<leader>co",
        action["source.organizeImports"],
        desc = "Organize Imports",
      },
      {
        "<leader>cM",
        action["source.addMissingImports.ts"],
        desc = "Add missing imports",
      },
      {
        "<leader>cu",
        action["source.removeUnused.ts"],
        desc = "Remove unused imports",
      },
      {
        "<leader>cD",
        action["source.fixAll.ts"],
        desc = "Fix all diagnostics",
      },
      -- {
      --   "<leader>cV",
      --   function()
      --     LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
      --   end,
      --   desc = "Select TS workspace version",
      -- },
    },
  },
}

return {} -- tmp disable
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "javascript",
--         "typescript",
--         "tsx",
--         "jsdoc",
--       })
--     end,
--   },
--
--   {
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = vim.list_extend(
--         opts.ensure_installed,
--         vim.list_extend(vim.tbl_keys(servers), {
--           "prettierd", -- formatter
--           { "eslint_d", version = "14.3.0" }, -- linter
--           "eslint",
--           "js-debug-adapter", -- dap
--         })
--       )
--
--       return opts
--     end,
--   },
--
--   {
--     "mfussenegger/nvim-lint",
--     opts = function(_, opts)
--       vim.env.ESLINT_D_PPID = vim.fn.getpid() -- which parent process to monitor; kill deamon if this closes
--       vim.env.ESLINT_D_MISS = "ignore" -- how to behave if local eslint is missing
--       return vim.tbl_deep_extend("force", opts, {
--         linters_by_ft = {
--           typescript = { "eslint_d" },
--           javascript = { "eslint_d" },
--           -- typescriptreact = { "eslint" },
--           -- javascriptreact = { "eslint" },
--         },
--       })
--     end,
--   },
--
--   -- {
--   --   "pmizio/typescript-tools.nvim",
--   --   dependencies = {
--   --     "nvim-lua/plenary.nvim",
--   --   },
--   --   opts = {},
--   --   ft = {
--   --     "javascript",
--   --     "javascriptreact",
--   --     "typescript",
--   --     "typescriptreact",
--   --   },
--   -- },
--
--   { -- Autoformat
--     "stevearc/conform.nvim",
--     opts = function(_, opts)
--       return vim.tbl_deep_extend("force", {
--         formatters_by_ft = {
--           javascript = { "prettierd", "prettier", stop_after_first = true },
--           typescript = { "prettierd", "prettier", stop_after_first = true },
--         },
--       }, opts)
--     end,
--   },
-- }
