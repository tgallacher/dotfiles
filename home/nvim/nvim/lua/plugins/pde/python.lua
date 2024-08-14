-- local lsp_util = require("lspconfig.util")

-- @see https://github.com/bellini666/dotfiles/blob/master/vim/lua/utils.lua#L25C3-L30C4
local function ensure_tables(obj, ...)
  for _, sub in ipairs({ ... }) do
    obj[sub] = obj[sub] or {}
    obj = obj[sub]
  end
end

-- @see https://github.com/bellini666/dotfiles/blob/master/vim/lua/utils.lua#L108C3-L144C4
-- Note: This assumes the use of "poetry" to manage python dependencies
local python_path = nil
local function find_python()
  if python_path ~= nil then
    return python_path
  end

  local p
  if vim.env.VIRTUAL_ENV then
    p = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python3")
  else
    local env_info = nil

    local poetry_root = vim.fs.root(0, { "poetry.lock" })
    if poetry_root then
      env_info = vim.fn.system({ "poetry", "env", "info", "--path", "-C", poetry_root })
    end

    if env_info ~= nil and string.find(env_info, "could not find") == nil then
      p = vim.fs.joinpath(env_info:gsub("\n", ""), "bin", "python3")
    else
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
    end
  end

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
    settings = {
      indent_width = 4,
    },
  },
  pyright = {
    settings = {
      filetypes = { "python" },
      -- typeCheckingMode = "off", -- use mypy instead
      -- reportInvalidTypeForm = "error",
      -- reportMissingImports = "error",
      -- reportUndefinedVariable = "error",
      python = {
        analysis = {
          typeCheckingMode = "off", -- use mypy instead
          -- from pt web's pyrightconfig.json
          reportInvalidTypeForm = "error",
          reportMissingImports = "error",
          reportUndefinedVariable = "error",
          -- from https://github.com/bellini666/dotfiles/blob/master/vim/lua/config/lsp.lua#L137-L141
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          disableOrganizeImports = true,
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

      local python_path = find_python()

      config.settings.python.pythonPath = python_path

      ensure_tables(initialize_params.initializationOptions, "settings", "python")
      initialize_params.initializationOptions.settings.python.pythonPath = python_path
    end,
  },
}

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     vim.opt.shiftwidth = 4
--     vim.opt.tabstop = 4
--     vim.opt.softtabstop = 4
--   end,
-- })

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
      opts.ensure_installed = vim.list_extend(
        opts.ensure_installed,
        vim.list_extend(vim.tbl_keys(servers), {
          -- "ruff",
          "mypy",
          -- "black",
          "debugpy",
        })
      )
      return opts
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          python = { "ruff", "mypy" },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, { servers = servers })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        formatters_by_ft = {
          j2 = { "djlint" },
          python = { "ruff_format" },
        },
      })
    end,
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

      vim.keymap.set("n", "<localleader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<localleader>dr", function()
        require("dap-python").test_method()
      end, { desc = "Toggle breakpoint" })
    end,
  },
}
