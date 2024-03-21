return {
  { -- Note: To see this don't use `nvim .` in a dir. Instead just use `nvim`.
    -- This will prevent netrw kicking in, and then Nvim Tree hijacking that and showing the tree nav
    "goolord/alpha-nvim",
    lazy = true,
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[

       ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
       ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
       ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
       ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
       ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
       ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

    ]]

      local function getGreeting()
        local tableTime = os.date("*t")
        local datetime = os.date(" %Y-%m-%d \t  %H:%M:%S")
        local hour = tableTime.hour
        local greetingsTable = {
          [1] = "  Sleep well",
          [2] = "  Good morning",
          [3] = "  Good afternoon",
          [4] = "  Good evening",
          [5] = "󰖔  Good night",
        }
        local greetingIndex = 0
        if hour == 23 or hour < 7 then
          greetingIndex = 1
        elseif hour < 12 then
          greetingIndex = 2
        elseif hour >= 12 and hour < 18 then
          greetingIndex = 3
        elseif hour >= 18 and hour < 21 then
          greetingIndex = 4
        elseif hour >= 21 then
          greetingIndex = 5
        end
        return "\t\t\t" .. datetime .. "\t\t\t" .. greetingsTable[greetingIndex]
      end

      local greeting = getGreeting()
      dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("r", "󰄉 " .. " Recent files", ":lua require('telescope.builtin').oldfiles({ only_cwd = true })<CR>"),
        dashboard.button("f", " " .. " Find file", ":lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>"),
        dashboard.button("g", "󰷾 " .. " Find text", ":lua require('telescope.builtin').live_grep()<CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      -- set highlight
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local version = "  󰥱 v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
          local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          local footer = version .. "\t" .. plugins .. "\n"
          dashboard.section.footer.val = footer
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}