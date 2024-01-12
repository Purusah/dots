vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("purusah.plugins.comment"),
  require("purusah.plugins.completion"),
  require("purusah.plugins.conform"),
  require("purusah.plugins.copilot"),
  require("purusah.plugins.diffview"),
  require("purusah.plugins.gitsigns"),
  require("purusah.plugins.indent_blankline"),
  require("purusah.plugins.lspconfig"),
  require("purusah.plugins.lualine"),
  require("purusah.plugins.tabby"),
  require("purusah.plugins.telescope"),
  require("purusah.plugins.theme-github"),
  require("purusah.plugins.theme-oxocarbon"),
  require("purusah.plugins.theme-tokyonight"),
  require("purusah.plugins.treesitter"),
  require("purusah.plugins.which_key"),
  require("purusah.plugins.vim-illuminate"),
  -- { import = 'purusah.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- set completeopt=menu,menuone,noselect
vim.opt.background = "dark" -- set this to dark or light
require("purusah.configs.colorscheme")

vim.o.autoindent = true
vim.o.encoding = "UTF-8"
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.list = true
vim.o.ruler = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.showmode = true
vim.o.syntax = "enable"
vim.o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.o.undofile = true
vim.tabstop = 4
vim.softtabstop = 4
vim.smarttab = 4
vim.splitbelow = true
vim.splitright = true

-- Window
vim.o.title = true

-- treesitter folding
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99 -- first usage of zc folds everything
vim.o.foldmethod = "expr"
vim.o.nofoldenable = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
-- vim-gitgutter suggestion is 1000, default 4000
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

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

-- [[ Keymaps.Jump ]]
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump Half Page Down and Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump Half Page Up and Center" })

-- [[ Keymaps.Buffer]]
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Buffer: toggle", silent = true })
vim.keymap.set("n", "<leader>bd", ":b#|bd#<CR>", { desc = "[B]uffer: delete current buffer", silent = true })
vim.keymap.set("n", "<leader>bh", ":new<CR>", { desc = "[B]uffer [H]orizontal  Split", silent = true })
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { desc = "Buffer: list", silent = true })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer: go to next", silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Buffer: go to previous", silent = true })
vim.keymap.set("n", "<leader>bs", ":ls<CR>:buffer<Space>", { desc = "Buffer: list and select", silent = true })
vim.keymap.set("n", "<leader>bu", ":ls<CR>:bdelete<Space>", { desc = "Buffer: list and delete", silent = true })
vim.keymap.set("n", "<leader>bv", ":vnew<CR>", { desc = "Buffer: vertical split", silent = true })
-- " nnoremap <silent> <leader>bk :bd!<CR> -- kill buffer

-- [[ Tabby]]
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true, desc = "[T]ab [A]dd" })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "[T]ab [C]lose" })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, desc = "[T]ab [O]nly" })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true, desc = "[T]ab Select [N]ext" })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true, desc = "[T]ab Select [P]revious" })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true, desc = "[T]ab [M]ove to [P]revious" })
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true, desc = "[T]ab [M]ove to [N]ext" })

-- [[ Termianl ]]
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- " Start terminal in insert mode
-- " au BufEnter * if &buftype == 'terminal' | :startinsert | endif
-- " nnoremap <silent> <leader>tt :terminal<CR>
-- " nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
-- " nnoremap <silent> <leader>th :new<CR>:terminal<CR>
-- " tnoremap <C-x> <C-\><C-n><C-w>q

-- vim.keymap.set("n", "<C-b>", function() require("fidget").notify("This is from fidget.notify()!") end)
-- Not Supported with lazy.nvim
-- vim.keymap.set('n', '<leader>cr', ':source $MYVIMRC<CR>', { desc = '[C]onfiguration [R]eload', silent = true })
-- vim.keymap.set('n', '<leader>ce', ':e $MYVIMRC<CR>', { desc = '[C]onfiguration [E]dit', silent = true })

-- redraw screan and clear search highlighted items
-- http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
-- nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

-- [[ LSP formt on save ]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- lua for nvim: https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- print(vim.opt.autoindent)
-- print(vim.opt.autoindent:get())
-- print(vim.inspect(vim.opt.autoindent))
-- :lua = vim.opt.autoindent
--
-- vim: ts=2 sts=2 sw=2 et
