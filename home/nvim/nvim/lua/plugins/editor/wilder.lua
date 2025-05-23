local colors = require("plugins.colors")

return {
  {
    -- Note: After first install, need to run within Neovim the following cmd::
    --
    -- :UpdateRemotePlugins
    --
    "gelguy/wilder.nvim",
    keys = { ":", "/", "?" },
    config = function()
      local wilder = require("wilder")
      -- Enable wilder when pressing :, / or ?
      wilder.setup({ modes = { ":", "/", "?" } })

      -- Enable fuzzy matching for commands and buffers
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            -- to use ripgrep : {'rg', '--files'}
            -- to use fd      : {'fd', '-tf'}
            file_command = { "fd", "-tf" },
            dir_command = { "fd", "-td" },
            -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
            -- found at https://github.com/nixprime/cpsm
            filters = { "fuzzy_filter", "difflib_sorter" },
          }),
          wilder.cmdline_pipeline({ language = "python", fuzzy = 1, set_pcre2_pattern = 1 }),
          wilder.python_search_pipeline({
            -- pattern = "fuzzy"
            -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
            pattern = wilder.python_fuzzy_pattern(),
            -- omit to get results in the order they appear in the buffer
            sorter = wilder.python_difflib_sorter(),
            -- can be set to 're2' for performance, requires pyre2 to be installed
            -- see :h wilder#python_search() for more details
            engine = "re",
          })
          -- wilder.vim_search_pipeline({ fuzzy = 1 })
        ),
      })

      -- local highlighters = {
      --   wilder.pcre2_highlighter(),
      --   wilder.basic_highlighter(),
      -- }

      wilder.set_option(
        "renderer",
        wilder.wildmenu_renderer({
          -- [":"] = wilder.popupmenu_renderer({
          --   highlighter = highlighters,
          -- }),
          -- ["/"] = wilder.wildmenu_renderer({
          --   highlighter = highlighters,
          -- }),
          highlighter = wilder.basic_highlighter(),
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = colors.accent, background = colors.bg } }),
            default = wilder.make_hl("WilderPmenu", "Pmenu", { { a = 1 }, { a = 1 }, { background = colors.bg } }),
          },
        })
      )

      -- change menu to Popup
      -- wilder.set_option( "renderer",
      --   wilder.popupmenu_renderer({
      --     highlighter = {
      --       wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
      --       wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
      --       -- at https://github.com/romgrk/fzy-lua-native
      --     },
      --     highlights = {
      --       accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = palette.mauve } }),
      --     },
      --     left = {' ', wilder.popupmemu_devicons()},
      --   })
      -- )
      --
      -- -- apply border to popup
      -- wilder.set_option( "renderer",
      --   wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
      --     highlighter = wilder.basic_highlighter(),
      --     highlights = {
      --       default = text_highlight,
      --       border = accent_highlight,
      --       accent = accent_highlight,
      --     },
      --     pumblend = 5,
      --     min_height = "25%",
      --     max_height = "25%",
      --     border = "rounded",
      --     left = { " ", wilder.popupmenu_devicons() },
      --     right = { " ", wilder.popupmenu_scrollbar() },
      --   }))
      -- )
    end,
  },
}
