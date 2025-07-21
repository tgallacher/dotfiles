return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "default",

      -- ["<C-e>"] = { "cancel" },
      -- ["<C-y>"] = { "accept", "hide" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    cmdline = {
      -- auto_insert = true,
      -- keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },

    completion = {
      -- (Default) Only show the documentation popup when manually triggered
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      menu = {
        -- nvim-cmp style menu
        -- draw = {
        --   columns = {
        --     { "label", "label_description", gap = 1 },
        --     { "kind_icon", "kind" },
        --   },
        -- },
      },
      -- ghost_text = { enabled = true, show_with_menu = true, show_without_menu = true },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        -- ensure path completion is always from where nvim was run, e.g. repo root
        -- info: can change with `:cwd`
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        "exact",
        "score",
        "sort_text",
      },
    },
    -- Experimental signature help support
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
