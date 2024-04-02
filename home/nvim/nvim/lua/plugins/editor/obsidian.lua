local function createNoteWithDefaultTemplate()
  local TEMPLATE_FILENAME = "default-note"
  local obsidian = require("obsidian").get_client()
  local utils = require("obsidian.util")

  -- prevent Obsidian.nvim from injecting it's own frontmatter table
  obsidian.opts.disable_frontmatter = true

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
  -- hack: delete empty lines before frontmatter; template seems to be injected at line 2
  vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
end

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- latest release instead of commit
    lazy = true,
    ft = "markdown",
    -- only load on Obsidian vault
    event = {
      "BufReadPre " .. vim.fn.expand("~/Code/tgallacher/obsidian/**.md"),
      "BufNewFile " .. vim.fn.expand("~/Code/tgallacher/obsidian/**.md"),
    },
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
          -- This is equivalent to the default behavior.
          path = spec.dir / tostring(spec.id)
        end
        return path:with_suffix(".md")
      end,
    },
  },
}
