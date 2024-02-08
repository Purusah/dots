-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ File Browser ]]
-- Auto start when opening a directory
vim.cmd([[autocmd StdinReadPre * let s:std_in=1]])
vim.cmd(
  [[autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe "lua require('telescope').extensions.file_browser.file_browser()" | endif]]
)

-- [[ LSP formt on save ]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- vim: ts=2 sts=2 sw=2 et
