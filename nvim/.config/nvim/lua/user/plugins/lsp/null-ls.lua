local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
	return
end

local lspconfigs = require "user.plugins.lsp.servers" 

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

mason_null_ls.setup({
  ensure_installed = lspconfigs.servers,
  automatic_installations = false,
  handlers = {},
})

null_ls.setup({
	debug = false,
	sources = {
	-- 	formatting.prettier,
	-- 	formatting.stylua,
 --    diagnostics.eslint_d.with({ -- js/ts linter
 --      -- only enable eslint if root has .eslintrc.js 
 --      condition = function(utils)
 --        -- TODO: add support for all ESLint config file types
 --        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
 --      end,
 --    }),
	},
  -- -- configure format on save
  -- on_attach = function(current_client, bufnr)
  --   if current_client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format({
  --           filter = function(client)
  --             --  only use null-ls for formatting instead of lsp server
  --             return client.name == "null-ls"
  --           end,
  --           bufnr = bufnr,
  --         })
  --       end,
  --     })
  --   end
  -- end,
})
