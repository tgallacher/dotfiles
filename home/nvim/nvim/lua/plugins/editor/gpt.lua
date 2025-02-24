return {
  "jackMort/ChatGPT.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    -- see: home/terminal/zsh.nix
    api_key_cmd = vim.fn.stdpath("data") .. "/get_openai_api_key.sh",
    openai_params = {
      model = "gpt-4o-mini",
      max_tokens = 500,
    },
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>cc", ":ChatGPT<cr>", desc = "[C]hatGPT Open interactive [c]hat" },
    { "<leader>ct", ":ChatGPTRun add_tests<cr>", desc = "[C]hatGPT add [t]ests" },
    { "<localleader>ce", ":ChatGPTRun explain_code<cr>", mode = "v", desc = "[C]hatGPT [e]xplain highlighted code" },
  },
}
