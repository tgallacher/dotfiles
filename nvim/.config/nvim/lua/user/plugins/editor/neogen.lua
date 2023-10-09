return {
  -- Better JSDoc (or equiv) support
  "danymat/neogen",
  opts = {
    snippet_engine = "luasnip",
    enabled = true,
    languages = {
      lua = {
        template = {
          annotation_convention = "ldoc",
        },
      },
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
      rust = {
        template = {
          annotation_convention = "rustdoc",
        },
      },
      javascript = {
        template = {
          annotation_convention = "jsdoc",
        },
      },
      typescript = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
    },
  },
  --stylua: ignore
  keys = {
    { "<localleader>lgd", function() require("neogen").generate() end, desc = "Annotation", },
    { "<localleader>lgc", function() require("neogen").generate { type = "class" } end, desc = "Class", },
    { "<localleader>lgf", function() require("neogen").generate { type = "func" } end, desc = "Function", },
    { "<localleader>lgt", function() require("neogen").generate { type = "type" } end, desc = "Type", },
  },
}
