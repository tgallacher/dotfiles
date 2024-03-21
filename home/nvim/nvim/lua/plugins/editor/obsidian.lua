return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- latest release instead of commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.opt.conceallevel = 2
    end,
    opts = {
      open_app_foreground = true, -- focus app on `:ObsidianOpen`
      attachments = { img_folder = "999-files/assets" },
      workspaces = {
        {
          name = "personal",
          path = "~/Code/tgallacher/obsidian/obsidian-notes",
          overrides = {
            notes_subdir = "00-inbox", -- will review notes each week
          },
        },
        {
          name = "beamery",
          path = "~/Code/tgallacher/obsidian/beamery-notes",
        },
      },
      -- FIXME: Pull this from Obsidian config
      daily_notes = {
        folder = "10-areas/journaling/daily",
        date_format = "%Y-%m-%d",
        template = "journaling-daily-note.md",
      },
      templates = {
        subdir = "999-files/templates",
        date_format = "%Y%m%d%H%M%S",
        time_format = "%H:%M:%s",
        substitutions = {
          -- NOTE: nvim uses C strfmt not momentjs like Obsidian. So we replicate here
          ["date:YYYYMMDDHHmmss"] = function()
            return os.date("%Y%m%d%H%M%S")
          end,
        },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      -- @param title string|?
      -- @return string
      note_id_func = function()
        return os.date("%Y%m%d%H%M%S")
      end,
      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      -- @param spec { id: string, dir: obsidian.Path, title: string|? }
      -- @return string|obsidian.Path The full path to the new note.
      note_path_func = function(spec)
        local path
        if spec.title ~= nil then
          local title = tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
          path = spec.dir / title
        else
          -- This is equivalent to the default behavior.
          path = spec.dir / tostring(spec.id)
        end
        return path:with_suffix(".md")
      end,
    },
  },
}
