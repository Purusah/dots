-- copied from https://gist.github.com/hHaeni/b15938c2f41b178f476b1bc4cecc0271
local function iterlines(s)
  if s:sub(-1) ~= "\n" then
    s = s .. "\n"
  end
  return s:gmatch("(.-)\n")
end

-- find directory
local function find_dir(d)
  -- return if root
  if d == "/" then
    return d
  end
  -- initialize git_state variable
  if vim.b.git_state == nil then
    vim.b.git_state = { "", "", "", "" }
  end
  -- fix terminal
  if d:find("term://") ~= nil then
    return "/tmp"
  end
  -- fix fzf
  if d:find("/tmp/.*FZF") ~= nil then
    return "/tmp"
  end
  -- fix fugitive etc.
  if d:find("^%w+://") ~= nil then
    vim.b.git_state[1] = " " .. d:gsub("^(%w+)://.*", "%1") .. " "
    d = d:gsub("^%w+://", "")
  end
  -- check renaming
  local ok, err, code = os.rename(d, d)
  if not ok then
    if code ~= 2 then
      -- all other than not existing
      return d
    end
    -- not existing
    local newd = d:gsub("(.*/)[%w._-]+/?$", "%1")
    return find_dir(newd)
  end
  -- d ok
  return d
end

-- get git status
local function git_status()
  vim.b.git_state = { "", "", "" }
  -- get & check file directory
  file_dir = find_dir(vim.fn.expand("%:p:h"))
  -- check fugitive etc.
  if vim.b.git_state[1] ~= "" then
    return "u"
  end
  -- capture git status call
  local cmd = "git -C " .. file_dir .. " status --porcelain -b 2> /dev/null"
  local handle = assert(io.popen(cmd, "r"), "")
  -- output contains empty line at end (removed by iterlines)
  local output = assert(handle:read("*a"))
  -- close io
  handle:close()

  local git_state = { "", "", "", "" }
  -- branch coloring: 'o': up to date with origin; 'd': head detached; 'm': not up to date with origin
  local branch_col = "o"

  -- check if git repo
  if output == "" then
    -- not a git repo
    -- save to variable
    vim.b.git_state = git_state
    -- exit
    return branch_col
  end

  -- get line iterator
  local line_iter = iterlines(output)

  -- process first line (HEAD)
  local line = line_iter()
  if line:find("%(no branch%)") ~= nil then
    -- detached head
    branch_col = "d"
  else
    -- on branch
    local ahead = line:gsub(".*ahead (%d+).*", "%1")
    local behind = line:gsub(".*behind (%d+).*", "%1")
    -- convert non-numeric to nil
    ahead = tonumber(ahead)
    behind = tonumber(behind)
    if behind ~= nil then
      git_state[1] = "↓ " .. tostring(behind) .. " "
    end
    if ahead ~= nil then
      git_state[1] = git_state[1] .. "↑ " .. tostring(ahead) .. " "
    end
  end

  -- loop over residual lines (files) &
  -- store number of files
  local git_num = { 0, 0, 0 }
  for line in line_iter do
    branch_col = "m"
    -- get first char
    local first = line:gsub("^(.).*", "%1")
    if first == "?" then
      -- untracked
      git_num[3] = git_num[3] + 1
    elseif first ~= " " then
      -- staged
      git_num[1] = git_num[1] + 1
    end
    -- get second char
    local second = line:gsub("^.(.).*", "%1")
    if second == "M" then
      -- modified
      git_num[2] = git_num[2] + 1
    end
  end

  -- build output string
  if git_num[1] ~= 0 then
    git_state[2] = "● " .. git_num[1]
  end
  if git_num[2] ~= 0 then
    git_state[3] = "+ " .. git_num[2]
  end
  if git_num[3] ~= 0 then
    git_state[4] = "… " .. git_num[3]
  end

  -- save to variable
  vim.b.git_state = git_state

  return branch_col
end

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
            -- diff_color = {
            --   added = "LuaLineDiffAdd", -- Changes the diff's added color
            --   modified = "LuaLineDiffChange", -- Changes the diff's modified color
            --   removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
            -- },
            symbols = { added = "+", modified = "~", removed = "-" },
            -- {
            --   source = nil, -- A function that works as a data source for diff.
            --   -- It must return a table as such:
            --   --   { added = add_count, modified = modified_count, removed = removed_count }
            --   -- or nil on failure. count <= 0 won't be displayed.
            -- },
            source = function()
              git_status()
              local state = vim.b.git_state

              return { added = tonumber(state[2]), modified = tonumber(state[3]), removed = 4 }
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
              local parent_dir = vim.fs.basename(vim.fs.dirname(vim.fn.expand("%")))

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
