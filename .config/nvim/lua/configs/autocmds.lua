-- Auto start file browser when opening a directory
vim.cmd([[autocmd StdinReadPre * let s:std_in=1]])
vim.cmd(
  [[autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe "lua require('telescope').extensions.file_browser.file_browser()" | endif]]
)

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- [[ LSP formt on save ]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Update global git status
local git_timer = vim.uv.new_timer()
local git_helper = require("helpers.git")

git_timer:start(
  1000,
  10000,
  vim.schedule_wrap(function() -- Waits 1000ms, then repeats every 1000ms
    git_helper.update_x_git_status()
  end)
)

-- vim: ts=2 sts=2 sw=2 et
