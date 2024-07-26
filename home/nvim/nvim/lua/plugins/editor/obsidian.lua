local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = "default-note"
  local obsidian = require("obsidian").get_client()
  local utils = require("obsidian.util")

  -- prompt for note title
  -- @see: borrowed from obsidian.command.new
  local note
  local title = utils.input("Enter title or path (optional): ")
  if not title then
    return
  elseif title == "" then
    title = nil
  end

  note = obsidian:create_note({ title = title, no_write = true })

  if not note then
    return
  end
  -- open new note in a buffer
  obsidian:open_note(note, { sync = true })
  -- NOTE: make sure the template folder is configured in Obsidian.nvim opts
  obsidian:write_note_to_buffer(note, { template = TEMPLATE_FILENAME })
end

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- latest release instead of latest commit
    lazy = true,
    event = "VeryLazy",
    ft = "markdown",
    -- only load on Obsidian vault
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~/Code/tgallacher/obsidian/"),
    --   "BufNewFile " .. vim.fn.expand("~/Code/tgallacher/obsidian/"),
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.opt.conceallevel = 2

      vim.keymap.set("n", "<leader>nn", createNoteWithDefaultTemplate, { desc = "[N]ew Obsidian [N]ote" })
    end,
    opts = {
      open_app_foreground = true, -- focus app on `:ObsidianOpen`
      attachments = { img_folder = "999-files/assets" },
      wiki_link_func = "prepend_note_id",
      new_notes_loction = "notes_subdir", -- should use `notes_subdir` setting
      workspaces = {
        {
          name = "personal",
          path = "~/Code/tgallacher/obsidian",
          overrides = {
            notes_subdir = "00-inbox", -- will review notes each week
          },
        },
      },
      -- FIXME: Can we pull this from Obsidian's config?
      daily_notes = {
        date_format = "%Y-%m-%d",
        template = "journaling-daily-note.md",
        folder = "10-areas/journaling/daily",
      },
      templates = {
        subdir = "999-files/templates",
        date_format = "%Y-%m-%d",
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
      note_id_func = function(title)
        local name = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            name = name .. string.char(math.random(65, 90))
          end
        end
        return name
        -- return os.date("%Y%m%d%H%M%S")
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
          -- This is equivalent to the default behaviour.
          path = spec.dir / tostring(spec.id)
        end
        return path:with_suffix(".md")
      end,
    },
  },
}
