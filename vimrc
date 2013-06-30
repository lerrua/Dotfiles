set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundles {
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'kien/ctrlp.vim'
    Bundle 'majutsushi/tagbar'
    Bundle 'klen/python-mode'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Yggdroot/indentLine'
    Bundle 'kana/vim-fakeclip'
    Bundle 'vim-scripts/grep.vim'
" }

filetype plugin indent on

" Enviroment {
    set encoding=utf-8 
    set t_Co=256
    colorscheme jellybeans
" }

" Coding {
    syntax enable
    set expandtab                   " use spaces, not tabs
    set number
    set novisualbell
    set pastetoggle=<F2>            " pastetoggle (sane indentation on pastes)
    set showcmd                     " show incomplete cmds down the bottom
    set showmode                    " Display the current mode
    set noswapfile                  " Don't use swapfile
    set nobackup                    " Don't create annoying backup files
    set noerrorbells                " No beeps
    let mapleader=","
    
    " Quit with 'q' instead of ':q'. VERY useful!
    map q :q<CR>

    " Copy text or cut to clipboard
    vmap <C-c> "+y
    vmap <C-x> "+d

    " De-selects highlighted text
    nnoremap <silent> <leader><space> :noh<cr>

    " Key mapping for tab navigation
    nmap <Tab> gt
    nmap <S-Tab> gT
    nnoremap <silent> <S-t> :tabnew<CR>

    " Key mapping for textmate-like indentation
    nmap <D-[> <<
    nmap <D-]> >>
    vmap <D-[> <gv
    vmap <D-]> >gv
" }

" Formatting {
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set autoindent
    set nowrap
    set list
    set listchars=tab:▸\ ,eol:¬     " whitespace characters from Textmate
    
    "statusline setup
    set statusline=%f               " tail of the filename
    set statusline+=%=              " left/right separator
    set statusline+=%l/             " cursor line
    set statusline+=%c,             " cursor column
    set statusline+=\%L,            " total lines
    set statusline+=\ %P            " percent through file
    set laststatus=2                " always show the statusline

    " File-type specific settings
    " Ruby
    au BufNewFile,BufRead *.rb,*.rbw,*.gemspec    set filetype=ruby
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" }

" Searching {
    set hlsearch                    " highlight matches
    set incsearch                   " searches starts as soon as you type - before pressing [enter]
" }

" Plugins {
    " NerdTree
    nnoremap <silent> <C-n> :NERDTreeToggle<CR>
    nnoremap <silent> <leader>n :NERDTreeFind<CR>
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    autocmd vimenter * if !argc() | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    " CtrlP
    let g:ctrlp_working_path_mode = 0
    nnoremap <silent> <C-t> :CtrlP<CR>
    nnoremap <silent> <C-b> :CtrlPBuffer<CR>
    nnoremap <silent> <F5> :CtrlPClearCache<CR>
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

    " Tagbar
    nmap <silent> <leader>l :TagbarToggle<CR>

    " Python-Mode
    let g:pymode_rope = 1           " Load rope plugin
    let g:pymode_rope_vim_completion = 1
    let g:pymode_lint = 1           " Load pylint code plugin
    let g:pymode_lint_onfly = 0
    let g:pymode_lint_write = 1     " Check code every save
    let g:pymode_lint_cwindow = 1   " Auto open cwindow if errors be finded
    let g:pymode_lint_message = 1   " Show error message if cursor placed at the error line
    let g:pymode_lint_hold = 0      " Hold cursor in current window when quickfix is open
    let g:pymode_lint_checker = "pyflakes,pep8"
    let g:pymode_folding = 0        " Enable python folding
    let g:pymode_virtualenv = 1     " Auto fix vim python paths if virtualenv enabled
    let g:pymode_indent = 1         " Enable pymode indentation
    let g:pymode_syntax_all = 1     " Enable all python highlightings
    let g:pymode_motion = 1         " Enable python objects and motion
    let g:pymode_utils_whitespaces = 1 " Autoremove unused whitespaces

    " indentLine
    let g:indentLine_color_term = 239
    let g:indentLine_char = '¦'

    " grep.vim
    nnoremap <silent> <leader>f :Rgrep<CR>
    let Grep_Default_Options = '-IR'
" }

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
