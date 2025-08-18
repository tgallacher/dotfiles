return {
  "robitx/gp.nvim",
  lazy = true,
  opts = {
    -- openai_api_key = os.execute(vim.fn.stdpath("data") .. "/get_openai_api_key.sh"),
    -- FIXME: make generic
    -- openai_api_key = { "/Users/tgallacher/.local/share/nvim/get_openai_api_key.sh" },
    curl_params = {},
    -- default_chat_agent = "ChatGPT4o-mini",
    default_chat_agent = "ChatClaude-3-7-Sonnet",
    providers = {
      anthropic = {
        disable = false,
        endpoint = "https://api.anthropic.com/v1/messages",
        secret = os.getenv("ANTHROPIC_API_KEY"),
      },
    },
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
    -- FIXME: `popup` buffers have a weird interaction with <C-y> to confirm autocomplete
    { "<leader>cc", ":GpChatToggle vsplit<CR>", desc = "[c]hatGPT Open interactive [c]hat" },
    { "<leader>cn", ":GpChatNew vsplit<CR>", desc = "[c]hatGPT Open [n]ew interactive chat" },
    { "<leader>cf", ":GpChatFinder popup<CR>", desc = "[c]hatGPT [f]ind chats" },
    { "<leader>cp", ":GpChatPaste vsplit<CR>", desc = "[c]hatGPT [p]aste chats", mode = { "v" } },
    { "<leader>cr", ":GpChatRewrite vsplit<CR>", desc = "[c]hatGPT [r]ewrite" },
  },
}
