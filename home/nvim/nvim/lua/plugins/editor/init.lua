return {
  { -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  { -- Easier management of buffers
    "ojroques/nvim-bufdel",
    event = { "BufReadPre", "BufNewFile" },
    opts = { quit = false },
    keys = {
      { "<leader>bc", "<cmd> BufDel<cr>", desc = "Close current buffer" },
      { "<leader>bC", "<cmd> BufDelOthers<cr>", desc = "Close all other buffers" },
    },
  },

  { -- autoclose html tags
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" },
    dependencies = { "nvim-treesitter" },
  },

  -- "gc<motion>" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      --- @diagnostic disable-next-line: missing-fields
      comment.setup({
        -- commenting tsx, jsx, html, etc
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- formatters_by_ft = { },
    },
  },

  { -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    "echasnovski/mini.ai",
    version = false, -- main branch
    opts = {
      n_lines = 500,
    },
  },

  -- add:    ys{motion}{char}
  -- delete: ds{char}
  -- change: cs{target}{replacement}
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      delay = 200,
      providers = { "lsp", "treesitter" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- autoclose parens, brackets, quotes, etc
  -- TODO: copy config to CMP:
  -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        cursor_pos_before = false,
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    event = { "BufReadPre", "BufNewFile" },
    --stylua: ignore
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "[H]arpoon [A]dd File" },
      { "<leader>hr", function() require("harpoon.mark").rm_file() end, desc = "[H]arpoon [R]emove File" },
      { "<leader>hca", function() require("harpoon.mark").clear_all() end, desc = "[H]arpoon [C]lear [A]ll files" },
      { "<leader>ho", function() require("harpoon.ui").toggle_quick_menu() end, desc = "[H]arpoon [T]oggle File Menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Open Harpoon File [1]" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Open Harpoon File [2]" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Open Harpoon File [3]" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Open Harpoon File [4]" },
      { "<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "Open Harpoon File [5]" },
    },
  },
}
