return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local colors = require("cyberdream.colors").default
    local cyberdream = require("lualine.themes.cyberdream")
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
          {
            "diff",
            colored = true,
            symbols = { added = "+", modified = "~", removed = "-" },
            source = function()
              -- It must return a table as such:
              --   { added = add_count, modified = modified_count, removed = removed_count }
              -- or nil on failure. count <= 0 won't be displayed.
              local git_status = vim.g.x_git_status
              if git_status == nil then
                return nil
              end

              return git_status
            end,
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            symbols = { modified = "  ", readonly = " 🔒" },
            path = 4,
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
          {
            "datetime",
            style = "  %H:%M ❤️",
          },
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
            fmt = function(name, context)
              local cwd_basename = vim.fs.basename(vim.loop.cwd())
              local parent_dir = vim.fs.basename(vim.fs.dirname(context.file))

              -- file in the root of cwd, and is not tab focus
              if cwd_basename == parent_dir then
                return name
              end

              -- file in the root of cwd, and is tab focus
              if parent_dir == "." then
                return name
              end

              return parent_dir .. "/" .. name
            end,
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
