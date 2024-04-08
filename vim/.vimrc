syntax on
set autoindent
set number
set mouse=a
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab

set showmatch
set encoding=utf-8
set ruler
filetyp plugin indent on

set noswapfile
set nobackup
set nowritebackup

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let mapleader=" "

inoremap jk <Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :q!<CR>
