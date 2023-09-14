local M = {}

local lsp_utils = require "user.plugins.editor.lsp.utils"
local icons = require "user.config.icons"

local function lsp_init()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      -- virtual_text = false,
      virtual_text = {
        spacing = 4,
        -- prefix = icons.ui.Exclamation,
        severity = {
          min = vim.diagnostic.severity.ERROR,
        },
      },
      signs = { active = signs },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  }

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Hover configuration
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

  -- Signature help configuration
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

function M.setup(_, opts)
  lsp_init() -- diagnostics, handlers

  lsp_utils.on_attach(function(client, bufnr)
    require("user.plugins.editor.lsp.format").on_attach(client, bufnr)
    require("user.plugins.editor.lsp.keymaps").on_attach(client, bufnr)

    local status_ok, illuminate = pcall(require, "illuminate")
    if status_ok then illuminate.on_attach(client) end
  end)

  -- Add bun for Node.js-based servers
  -- local lspconfig_util = require "lspconfig.util"
  -- local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
  -- lspconfig_util.on_setup = lspconfig_util.add_hook_before(lspconfig_util.on_setup, add_bun_prefix)

  local all_mslp_servers = {}
  -- get all the servers that are available thourgh mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  if have_mason then all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package) end
  local servers = opts.servers
  local capabilities = lsp_utils.capabilities()

  -- custom setup
  local setup = function(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, servers[server] or {})

    -- Augment setup within plugin setup opts; return true to
    -- prevent lspconfig.setup {} running
    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then return end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then return end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  local ensure_installed = {} ---@type string[]
  for server, sopts in pairs(servers) do
    if sopts then
      sopts = sopts == true and {} or sopts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if sopts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { setup }
  end
end

return M
