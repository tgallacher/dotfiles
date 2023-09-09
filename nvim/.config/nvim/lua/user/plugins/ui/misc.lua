return {
  -- core ui library used by various plugins
  "MunifTanjim/nui.nvim",

  -- filetype icons, used by many plugins
  "nvim-tree/nvim-web-devicons",

  -- dim inactive code sections
  {
    "folke/twilight.nvim",
    config = true,
    keys = {
      { "<leader>tw", ":Twilight <CR>", "n", { noremap = true, silent = true } },
    },
  },

  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    config = true,
    keys = {
      { "<leader>zm", ":ZenMode <CR>", "n", { noremap = true, silent = true } },
    },
  },
  
  -- visualise hex codes
  {
    "norcalli/nvim-colorizer.lua",
    main = "colorizer",
    config = true,
  },
}
