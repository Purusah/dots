"filetype plugin indent on

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

Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme tokyonight-moon

set autoindent
set background=dark " theme color
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set cursorcolumn
set cursorline
set encoding=UTF-8
set foldlevel=99 " first usage of zc folds everything
set list
set mouse=a
set number
set relativenumber
set ruler
set tabstop=4
set shiftwidth=4
set showcmd
set showmode
set smarttab
set softtabstop=4
set syntax=enable
set tabstop=4
set undodir=~/.config/nvim/undodir
set undofile

" vim-gitgutter suggestion, default 4000
set updatetime=1000

" treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable


" Auto start Neotree tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'Neotree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'Neotree' | endif


" mappings
" <silent> - suppress showing applied config
let mapleader=" "

" Shortcut to edit THIS configuration file
nnoremap <silent> <leader>ce :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file
nnoremap <silent> <leader>cs :source $MYVIMRC<CR>

" jump half page and center
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" toggle buffer (switch between current and last buffer)
" nnoremap <silent> <leader>bb <C-^>
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bnext<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bprevious<CR>

" list buffers
nnoremap <silent> <leader>bl :ls<CR>

" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" close buffer
nnoremap <silent> <leader>bd :bd<CR>

" kill buffer
" nnoremap <silent> <leader>bk :bd!<CR>

" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>

" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Start terminal in insert mode
" au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" nnoremap <silent> <leader>tt :terminal<CR>
" nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
" nnoremap <silent> <leader>th :new<CR>:terminal<CR>
" tnoremap <C-x> <C-\><C-n><C-w>q

" jump to next/previous hunk 
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
" nmap <Leader>hs <Plug>(GitGutterStageHunk)
" nmap <Leader>hu <Plug>(GitGutterUndoHunk)


" Rust
let g:rustfmt_autosave = 1


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
let g:airline_section_y = '' " hide file encoding information
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


" vim-gitgutter
" suppress the signs when a file has more than number of changes
let g:gitgutter_max_signs = 500
let g:gitgutter_show_msg_on_hunk_jumping = 1
" let g:gitgutter_enabled = 0
" let g:gitgutter_map_keys = 0


lua require('purusah')

