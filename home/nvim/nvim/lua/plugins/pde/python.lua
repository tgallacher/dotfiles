-- @see https://github.com/bellini666/dotfiles/blob/master/vim/lua/utils.lua#L25C3-L30C4
local function ensure_tables(obj, ...)
  for _, sub in ipairs({ ... }) do
    obj[sub] = obj[sub] or {}
    obj = obj[sub]
  end
end

-- @see https://github.com/bellini666/dotfiles/blob/master/vim/lua/utils.lua#L108C3-L144C4
-- -- Cache found path for current session
local python_path = nil
local function find_python()
  if python_path ~= nil then
    return python_path
  end

  local p
  if vim.env.VIRTUAL_ENV then
    p = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python3")
  else
    -- local env_info = nil

    -- local pyproject_root = vim.fs.root(0, { "pyproject.toml" })
    -- if pyproject_root then
    --   -- env_info = vim.fn.system({ "poetry", "env", "info", "--path", "-C", poetry_root })
    --   env_info = vim.fs.joinpath(pyproject_root, ".venv")
    -- end

    -- if env_info ~= nil and string.find(env_info, "could not find") == nil then
    --   -- FIXME: this doesn't map to a valid python binary
    --   p = vim.fs.joinpath(env_info:gsub("\n", ""), "bin", "python3")
    -- else
    local venv_dir = vim.fs.find(".venv", {
      upward = true,
      type = "directory",
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    })

    if #venv_dir > 0 then
      p = vim.fs.joinpath(venv_dir[1], "bin", "python3")
    else
      p = "python3"
    end
    -- end
  end

  -- cache
  python_path = p

  return p
end

local servers = {
  djlint = {
    settings = {
      indent = 4,
      max_line_length = 120,
    },
  },
  ruff = {
    cmd = { "ruff", "server" },
    settings = {
      indent_width = 4,
    },
  },
  basedpyright = {
    settings = {
      basedpyright = {
        filetypes = { "python" },
        -- from https://github.com/bellini666/dotfiles/blob/master/vim/lua/config/lsp.lua#L137-L141
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        disableOrganizeImports = true, -- NOTE: use ruff instead
        typeCheckingMode = "off", -- NOTE: use mypy instead
      },
      python = {
        analysis = {
          ignore = { "*" }, -- use ruff
          autoImportCompletions = true,
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
          diagnosticSeverityOverrides = {
            -- from pt web's pyrightconfig.json
            reportInvalidTypeForm = "error",
            reportMissingImports = "error",
            reportUndefinedVariable = "error",
            -- from astrovim
            reportUnusedImport = "information",
            reportUnusedFunction = "information",
            reportUnusedVariable = "information",
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalSubscript = "none",
            reportPrivateImportUsage = "none",
          },
        },
      },
    },
    -- set python interpreter to local virtual env
    before_init = function(initialize_params, config)
      -- @see: https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-965824580
      -- local p
      -- if vim.env.VIRTUAL_ENV then
      --   p = lsp_util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
      -- else
      --   p = utils.find_cmd("python3", ".venv/bin", config.root_dir)
      -- end
      --
      -- config.settings.python.pythonPath = p

      python_path = find_python()
      if not config.settings then
        config.settings = {}
      end
      if not config.settings.python then
        config.settings.python = {}
      end
      config.settings.python.pythonPath = python_path

      ensure_tables(initialize_params.initializationOptions, "settings", "python")
      initialize_params.initializationOptions.settings.python.pythonPath = python_path
    end,
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "python", "htmldjango" })
      return opts
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed, vim.list_extend(vim.tbl_keys(servers), { "mypy", "debugpy" }))
      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { servers = servers })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          python = { "mypy" },
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          j2 = { "djlint" },
          python = { "ruff_organize_imports", "ruff_format" },
        },
      })
    end,
  },

  { -- WIP type stubs which haven't made it into "typeshed" yet
    "microsoft/python-type-stubs",
  },

  { -- Find and switch virtual envs: Use if the auto path search above doesn't work
    "linux-cultist/venv-selector.nvim",
    -- lazy = true,
    branch = "regexp",
    enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
    dependencies = {
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    opts = {},
    cmd = "VenvSelect",
    keys = {
      "<Leader>vs",
      ":VenvSelect<CR>",
      desc = "[P]ython [v]irtualEnv [s]elect",
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

      require("dap-python").setup(path)

      vim.keymap.set("n", "<localleader>db", ":DapToggleBreakpoint<CR>", { desc = "[D]ap toggle [b]reakpoint" })
      -- stylua: ignore
      vim.keymap.set("n", "<localleader>dt", function() require("dap-python").test_method() end, { desc = "[D]ap [t]est method" })             end,
  },
}
