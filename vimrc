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
    Bundle 'tpope/vim-fugitive'
    Bundle 'Yggdroot/indentLine'
    Bundle 'vim-scripts/grep.vim'
    Bundle 'lerrua/snipmate.vim'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'xolox/vim-misc'
    Bundle 'sheerun/vim-polyglot'
    Bundle 'davidhalter/jedi-vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'szw/vim-maximizer'
" }


" Enviroment {
    filetype plugin indent on

    set t_Co=256
    set mouse=a
    set encoding=utf-8 
    set nobackup                    " Don't create annoying backup files
    set nowrap
    set noswapfile                  " Don't use swapfile
    set noerrorbells                " No beeps
    set history=1000                " remember more commands and search history
    set undolevels=1000             " use many muchos levels of undo

    colorscheme jellybeansX
" }

" Coding {
    syntax enable
    set expandtab                   " use spaces, not tabs
    set number
    set novisualbell
    set showcmd                     " show incomplete cmds down the bottom
    set showmode                    " Display the current mode
    set autoindent
    set copyindent                  " copy the previous indentation on autoindenting
    let mapleader=","
    nnoremap ; :
    
    " Quit with 'q' instead of ':q'. VERY useful!
    map q :q<CR>

    " Copy text or cut to system clipboard
    set clipboard=unnamed

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

    " Add keyboard shortcuts for navigating splits
    map <C-down> <c-w>j
    map <C-up> <c-w>k
    map <C-right> <c-w>l
    map <C-left> <c-w>h

    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>
" }

" Formatting {
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set title                       " change the terminal's title
    set list
    set listchars=tab:▸\ ,eol:·     " whitespace characters from Textmate
    set wildignore=*.swp,*.bak,*.pyc,*.class
    set smarttab                    " insert tabs on the start of a line according to
                                    "    shiftwidth, not tabstop
                                    "
 
    "statusline setup
    set statusline=%f               " tail of the filename
    set statusline+=%=              " left/right separator
    set statusline+=%l/             " cursor line
    set statusline+=%c,             " cursor column
    set statusline+=\%L,            " total lines
    set statusline+=\ %P            " percent through file
    set laststatus=2                " always show the statusline
" }

" Searching {
    set hlsearch                    " highlight matches
    set incsearch                   " searches starts as soon as you type - before pressing [enter]
" }
"

" GUI {
    if has("gui_running")
        set guioptions-=M           "remove menu bar
        set guioptions-=T           "remove toolbar
        set guioptions-=r           "remove right-hand scroll bar
        set listchars=tab:>-,trail:- " whitespace characters on gui

        if has("gui_gtk2")
            set guifont=Inconsolata\ 10
        elseif has("gui_macvim")
            set guifont=Menlo\ Regular:h14
        elseif has("gui_win32")
            set guifont=Consolas:h11:cANSI
        endif
    endif
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
    let g:ctrlp_match_window_bottom = 0
    let g:ctrlp_match_window_reversed = 0
    let g:ctrlp_working_path_mode = 0

    " Tagbar
    nmap <silent> <leader>l :TagbarToggle<CR>

    " indentLine
    let g:indentLine_color_term = 239
    let g:indentLine_char = '¦'

    " grep.vim
    nnoremap <silent> <leader>f :Rgrep<CR>
    let Grep_Default_Options = '-IR'
    
    " vim-powerline
    let g:Powerline_symbols = 'unicode'

    " vim-polyglot javascript
    let javascript_enable_domhtmlcss = 1

    " vim-ruby
    au BufNewFile,BufRead *.rb,*.rbw,*.gemspec    set filetype=ruby
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

    " jedi-vim
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#goto_definitions_command = "<leader>d"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#show_call_signatures = "1"

    " syntastic
    let g:syntastic_python_checkers=['python', 'flake8']
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_auto_loc_list=1

    " vim-maximizer
    inoremap <silent><F3> <C-o>:MaximizerToggle<CR>
" }

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
