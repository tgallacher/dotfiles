return {
  {
    "gelguy/wilder.nvim",
    keys = { ":", "/", "?" },
    dependencies = { "catppuccin/nvim" },
    config = function()
      -- Note: After first install, need to run within Neovim the following cmd::
      --
      -- :UpdateRemotePlugins
      --
      local wilder = require("wilder")
      local palette = require("catppuccin.palettes").get_palette("mocha")

      -- Create a highlight group for the popup menu
      local text_highlight = wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = palette.text } })
      local accent_highlight = wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = palette.rosewater } })

      -- Enable wilder when pressing :, / or ?
      wilder.setup({ modes = { ":", "/", "?" } })

      -- Enable fuzzy matching for commands and buffers
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({ fuzzy = 1 }),
          wilder.vim_search_pipeline({ fuzzy = 1 })
        ),
      })

      wilder.set_option('renderer', wilder.wildmenu_renderer({
        highlighter = wilder.basic_highlighter(),
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = palette.red } }),
          },
      }))

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
