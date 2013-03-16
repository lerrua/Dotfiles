set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" my bundles
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'

filetype plugin indent on

" Enviroment
set encoding=utf-8 
set t_Co=256
colorscheme ir_black

" Coding
syntax enable
set expandtab                   " use spaces, not tabs
set number
set visualbell
set pastetoggle=<F2>            " pastetoggle (sane indentation on pastes)
set showcmd                     " show incomplete cmds down the bottom
set showmode                    " Display the current mode

" Formatting
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

" Plugins {
    " NerdTree
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

    " CtrlP
    let g:ctrlp_working_path_mode = 0
    nnoremap <silent> <C-t> :CtrlP<CR>
    nnoremap <silent> <C-b> :CtrlPBuffer<CR>
    let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.pyc$|\.exe$\|\.so$\|\.dll$' }

    " Tagbar
    nmap <silent> <C-l> :TagbarToggle<CR>
" }
