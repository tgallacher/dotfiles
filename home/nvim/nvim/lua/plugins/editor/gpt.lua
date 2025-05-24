return {
  "robitx/gp.nvim",
  lazy = true,
  opts = {
    -- openai_api_key = os.execute(vim.fn.stdpath("data") .. "/get_openai_api_key.sh"),
    -- FIXME: make generic
    openai_api_key = { "/Users/tgallacher/.local/share/nvim/get_openai_api_key.sh" },
    curl_params = {},
    default_chat_agent = "ChatGPT4o-mini",
    hooks = {
      -- example of adding command which writes unit tests for the selected code
      UnitTests = function(gp, params)
        local template = "I have the following code from {{filename}}:\n\n"
          .. "```{{filetype}}\n{{selection}}\n```\n\n"
          .. "Please respond by writing table driven unit tests for the code above."
        local agent = gp.get_command_agent()
        gp.Prompt(params, gp.Target.enew, agent, template)
      end,

      -- example of adding command which explains the selected code
      Explain = function(gp, params)
        local template = "I have the following code from {{filename}}:\n\n"
          .. "```{{filetype}}\n{{selection}}\n```\n\n"
          .. "Please respond by explaining the code above."
        local agent = gp.get_chat_agent()
        gp.Prompt(params, gp.Target.popup, agent, template)
      end,
    },
  },
  config = function(_, opts)
    require("gp").setup(opts)
  end,
  keys = {
    { "<leader>cc", ":GpChatToggle popup<CR>", desc = "[C]hatGPT Open interactive [c]hat" },
    { "<leader>cf", ":GpChatToggle popup<CR>", desc = "[C]hatGPT [f]ind chats" },
    { "<leader>cp", ":GpChatPaste popup<CR>", desc = "[C]hatGPT [p]aste chats" },
    { "<leader>cr", ":GpChatRewrite popup<CR>", desc = "[C]hatGPT [r]ewrite" },
  },
}
