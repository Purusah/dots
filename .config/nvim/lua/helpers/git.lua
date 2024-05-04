local P = {}

-- original implementation https://gist.github.com/ChHaeni/b15938c2f41b178f476b1bc4cecc0271
local function iterlines(s)
  if s:sub(-1) ~= "\n" then
    s = s .. "\n"
  end
  return s:gmatch("(.-)\n")
end

function P.update_x_git_status()
  local git_status = { added = 0, modified = 0, removed = 0 }
  vim.g.x_git_status = git_status

  local cmd = "git status --porcelain -b 2> /dev/null"
  local handle = assert(io.popen(cmd, "r"), "")
  -- output contains empty line at end (removed by iterlines)
  local output = assert(handle:read("*a"))
  -- close io
  handle:close()

  -- check if git repo
  if output == "" then
    return
  end

  local line_iter = iterlines(output)
  line_iter() -- skip first line (HEAD)

  for line in line_iter do
    local first_char = string.sub(line, 1, 1)
    if first_char == "A" then
      git_status.added = git_status.added + 1
    end

    local second_char = string.sub(line, 2, 2)
    if second_char == "M" then
      git_status.modified = git_status.modified + 1
    elseif second_char == "D" then
      git_status.removed = git_status.removed + 1
    end
  end

  vim.g.x_git_status = git_status
end

return P
