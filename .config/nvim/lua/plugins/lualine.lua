return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local colors = require("cyberdream.colors").default
    local cyberdream = require("lualine.themes.cyberdream")
    local copilot_colors = {
      [""] = { fg = colors.grey, bg = colors.none },
      ["Normal"] = { fg = colors.grey, bg = colors.none },
      ["Warning"] = { fg = colors.red, bg = colors.none },
      ["InProgress"] = { fg = colors.yellow, bg = colors.none },
    }
    return {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = cyberdream, -- "auto",
        globalstatus = false,
        icons_enabled = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          { "diff" },
          -- TODO
          -- {
          --   "diff",
          --   colored = true, -- Displays a colored diff status if set to true
          --   diff_color = {
          --     added = "LuaLineDiffAdd", -- Changes the diff's added color
          --     modified = "LuaLineDiffChange", -- Changes the diff's modified color
          --     removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
          --   },
          --   symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
          --   source = nil, -- A function that works as a data source for diff.
          --   -- It must return a table as such:
          --   --   { added = add_count, modified = modified_count, removed = removed_count }
          --   -- or nil on failure. count <= 0 won't be displayed.
          -- },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            symbols = { modified = "  ", readonly = "", unnamed = "" },
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰝶 ",
            },
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            "progress",
          },
          {
            "location",
            color = { fg = colors.cyan, bg = colors.none },
          },
        },
        lualine_z = {
          function()
            return "  " .. os.date("%X") .. " 🚀 "
          end,
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "tabs",
            max_length = vim.o.columns * 2 / 3,
            mode = 2,
            use_mode_colors = true,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            "buffers",
            max_length = vim.o.columns / 3,
            mode = 4,
          },
        },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
