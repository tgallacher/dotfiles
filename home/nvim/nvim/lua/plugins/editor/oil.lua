-- INFO: From https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files

-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- build git status cache
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
        cwd = key,
        text = true,
      })
      local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- recommended to NOT lazy load
  opts = function()
    local git_status = new_git_status()
    -- Clear git status cache on refresh
    local isok, oil_actions = pcall(require, "oil.actions")
    if isok then
      local orig_refresh = oil_actions.refresh.callback
      oil_actions.refresh.callback = function(...)
        git_status = new_git_status()
        orig_refresh(...)
      end
    else
      print("Failed to load oil.actions module")
    end

    ---@module 'oil'
    ---@type oil.SetupOpts
    return {
      use_default_keymaps = true,
      keymaps = {
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = false,
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true, -- see :h oil.skip_confirm_for_simple_edit
      view_options = {
        show_hidden = false, -- Show files and directories that start with "."
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git" or name == "__pycache__"
        end,
        -- hide gitignored / show git tracked hidden files
        is_hidden_file = function(name, bufnr)
          local dir = require("oil").get_current_dir(bufnr)
          local is_dotfile = vim.startswith(name, ".") and name ~= ".."
          -- if no local directory (e.g. for ssh connections), just hide dotfiles
          if not dir then
            return is_dotfile
          end

          if is_dotfile then
            -- dotfiles are considered hidden unless tracked
            return not git_status[dir].tracked[name]
          else
            -- Check if file is gitignored
            return git_status[dir].ignored[name]
          end
        end,
      },
      constrain_cursor = "name", -- constrain to filename: only required when additional `columns` is spec'd below
      columns = {
        "icon",
        "permissions",
        "size",
        "type",
      },
    }
  end,
  keys = {
    -- stylua: ignore
    { "<leader>o", function() require("oil").toggle_float() end, { desc="Open [o]il.nvim"}},
  },
}
