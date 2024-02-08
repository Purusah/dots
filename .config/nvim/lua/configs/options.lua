-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.autoindent = true
vim.o.autowrite = true
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.encoding = "UTF-8"
vim.o.scrolloff = 8
vim.o.list = true
vim.o.ruler = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.showmode = true
vim.o.syntax = "enable"
vim.o.smartindent = true
vim.o.undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.o.undofile = true
vim.tabstop = 4
vim.softtabstop = 4
vim.smarttab = 4
vim.splitbelow = true
vim.splitright = true
vim.o.wrap = false

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

-- lua for nvim: https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- print(vim.opt.autoindent)
-- print(vim.opt.autoindent:get())
-- print(vim.inspect(vim.opt.autoindent))
-- :lua = vim.opt.autoindent

-- vim: ts=2 sts=2 sw=2 et
