set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" my bundles

filetype plugin indent on

set t_Co=256
colorscheme ir_black

" Coding
syntax enable
set expandtab                   " use spaces, not tabs
set encoding=utf-8 
set number
set visualbell

" Whitespaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set nowrap
set list
set listchars=tab:▸\ ,eol:¬     " whitespace characters from Textmate
set laststatus=2                " Always show the statusline

" Searching
set hlsearch                    " highlight matches
set incsearch                   " searches starts as soon as you type - before pressing [enter]
