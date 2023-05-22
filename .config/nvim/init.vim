filetype plugin indent on

call plug#begin('~/AppImages/nvim/plugins')

Plug 'https://github.com/vim-airline/vim-airline' " Status bar

Plug 'rust-lang/rust.vim' " Rust support
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'

Plug 'folke/tokyonight.nvim'

call plug#end()

colorscheme tokyonight-moon

set autoindent
set background=dark " theme color
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set cursorcolumn
set cursorline
set encoding=UTF-8
set list
set mouse=a
set number
set relativenumber
set ruler
set shiftwidth=4
set showcmd
set showmode
set smarttab
set softtabstop=4
set syntax=enable
set tabstop=4
set undodir=~/.config/nvim/undodir
set undofile

" treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" mappings
nnoremap <Space> <Leader>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

lua require('purusah')

