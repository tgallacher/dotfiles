return {
  	-- Automatically highlights other instances of the word under your cursor.
	-- This works with LSP, Treesitter, and regexp matching to find the other
	-- instances.
	{
		"RRethy/vim-illuminate",
    event = "BufReadPost",
    -- event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --   "neovim/nvim-lspconfig",
    --   "nvim-treesitter/nvim-treesitter",
    -- },
		opts = {
			delay = 200,
			-- large_file_cutoff = 2000,
			-- large_file_overrides = {
			-- 	providers = { "lsp" },
			-- },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},

  -- semantic highlighting for servers that don't support semantic tokens
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    opts = {
      color = "#ef9062",
      use_colorpalette = false,
      disable = function(_, bufnr)
        if vim.b.semantic_tokens then
          return true
        end
        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        for _, c in pairs(clients) do
          local caps = c.server_capabilities
          if c.name ~= "null-ls" and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            vim.b.semantic_tokens = true
            return vim.b.semantic_tokens
          end
        end
      end,
    },
  },
}
