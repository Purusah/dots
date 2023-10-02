vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

require('lazy').setup({
  -- 'https://github.com/vim-airline/vim-airline' " Status bar
  -- 'airblade/vim-gitgutter'
  -- 'lukas-reineke/indent-blankline.nvim'

  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  {
    'rust-lang/rust.vim',
    config = function()
    end,
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'purusah.plugins.autoformat',
  require 'purusah.plugins.completion',
  require 'purusah.plugins.debug',
  require 'purusah.plugins.indent_blankline',
  require 'purusah.plugins.lspconfig',
  require 'purusah.plugins.neotree',
  require 'purusah.plugins.theme-oxocarbon',
  require 'purusah.plugins.theme-tokyonight',
  require 'purusah.plugins.treesitter',
  require 'purusah.plugins.which_key',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'purusah.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- set completeopt=menu,menuone,noselect
vim.opt.background = "dark"     -- set this to dark or light
vim.cmd.colorscheme "oxocarbon" -- 'tokyonight-moon'

vim.o.autoindent = true
vim.o.encoding = 'UTF-8'
-- vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.foldlevel = 99 -- first usage of zc folds everything
vim.o.list = true
vim.o.ruler = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.showmode = true
vim.o.syntax = 'enable'
vim.o.undodir = vim.fn.expand('~/.config/nvim/undodir')
vim.o.undofile = true
vim.tabstop = 4
vim.softtabstop = 4
vim.smarttab = 4


-- treesitter folding
vim.o.foldmethod = 'expr'
vim.o.nofoldenable = true
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Set highlight on search
-- vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
-- vim-gitgutter suggestion is 1000, default 4000
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- [[ Keymaps ]]

-- jump half page and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- " Shortcut to edit THIS configuration file
-- nnoremap <silent> <leader>ce :e $MYVIMRC<CR>
--
-- " Shortcut to source (reload) THIS configuration file
-- nnoremap <silent> <leader>cs :source $MYVIMRC<CR>

vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Buffer: toggle', silent = true })
-- " close buffer
-- nnoremap <silent> <leader>bd :bd<CR>
vim.keymap.set('n', '<leader>bg', ':ls<CR>:buffer<Space>', { desc = 'Buffer: list and select', silent = true })
vim.keymap.set('n', '<leader>bh', ':new<CR>', { desc = 'Buffer: horizontal  split', silent = true })
-- " kill buffer
-- " nnoremap <silent> <leader>bk :bd!<CR>
vim.keymap.set('n', '<leader>bl', ':ls<CR>', { desc = 'Buffer: list', silent = true })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Buffer: go to next', silent = true })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Buffer: go to previous', silent = true })
vim.keymap.set('n', '<leader>bv', ':vnew<CR>', { desc = 'Buffer: vertical split', silent = true })

-- " redraw screan and clear search highlighted items
-- "http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
-- nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ LSP formt on save ]]
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- [[ Neotree ]]
-- Auto start when opening a directory
vim.cmd [[autocmd StdinReadPre * let s:std_in=1]]
vim.cmd [[autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'Neotree' | endif]]

-- -- [[ Configure Telescope ]]
-- -- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
-- }

-- -- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- -- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })

-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Setup neovim lua configuration
require('neodev').setup()

-- vim: ts=2 sts=2 sw=2 et
