-- 
-- Plugin: "folke/noice"
--
require("noice").setup({
  -- lsp = {
  --   -- override = {
  --   --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --   --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --   --   ["vim.lsp.util.stylize_markdown"] = true,
  --   --   ["cmp.entry.get_documentation"] = true,
  --   -- },
  -- },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false,             -- use a classic bottom cmdline for search
    command_palette = true,           -- position the cmdline and popupmenu together
    long_message_to_split = true,     -- long messages will be sent to a split
    inc_rename = false,               -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,           -- add a border to hover docs and signature help
  },
  views = {
    -- cmdline_popupmenu = {
    --   position = "50%"
    -- },
    cmdline_popup = {
      position = "50%",
      size = {
        min_width = 120,
        -- width = 420,
        border = {
          style = "none"
        }
      }
    }
  }
})