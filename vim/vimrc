"-- Vim only startup --"
if !has('nvim')
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
    \| endif

    call plug#begin('~/.vim/plugged')
        Plug 'sheerun/vim-polyglot'
        Plug 'sainnhe/everforest'
        Plug 'christoomey/vim-tmux-navigator'
    call plug#end()

    " Split navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    
    set background=dark
    let g:everforest_background = 'hard'
    let g:everforest_better_performance = 1
    let g:everforest_enable_italic = 1
    let g:everforest_transparent_background = 1
    colorscheme everforest
endif

"-- Basics --"
set nocompatible
filetype plugin on
syntax on

set number                                                                                                                                                                                
set relativenumber
set hidden			" buffer switching without saving
set mouse=a			" enable mouse

"-- Look and feel --"
if has('termguicolors')
    set termguicolors
endif
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set nowrap
set scrolloff=10
set signcolumn=number

"-- Leader Key --"
let mapleader = " "
let maplocalleader = " "

"-- Searching --"
set ignorecase
set smartcase
set hlsearch
set incsearch

"-- Bindings -- "

" Split creation
nnoremap <leader>\ :vsplit<CR>
nnoremap <leader>- :split<CR>

" Buffer management
nnoremap <leader>w :w<CR> 
nnoremap <leader>q :q<CR> 
nnoremap <leader>bd :bdelete<CR> 
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprev<CR>

" Visual mode indenting
vnoremap < <gv
vnoremap > >gv

" Searching
nnoremap <Esc> :nohlsearch<CR>

nnoremap <leader>pv :Ex<CR>
tnoremap <Esc><Esc> <C-\><C-n>

