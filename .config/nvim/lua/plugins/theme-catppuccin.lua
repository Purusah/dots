return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    show_end_of_buffer = false,
    dim_inactive = {
      -- if true -> break transparent background
      enabled = false,
    },
    no_italic = false,
    no_bold = true,
    no_underline = false,
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        -- TODO: doesn't work
        WhichKey = { link = "NormalFloat" },
        WhichKeyBorder = { link = "FloatBorder" },
      }
    end,
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      illuminate = {
        enabled = true,
        lsp = false,
      },
      which_key = true,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
