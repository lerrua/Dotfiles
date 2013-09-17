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
    Bundle 'xolox/vim-session'
    Bundle 'davidhalter/jedi-vim'
    Bundle 'scrooloose/syntastic'
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
    set clipboard=unnamed
    set clipboard=unnamedplus

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
    map <c-j> <c-w>j
    map <c-k> <c-w>k
    map <c-l> <c-w>l
    map <c-h> <c-w>h
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

    " vim-session
    let g:session_autosave = 'no'

    " jedi-vim
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#goto_definitions_command = "<leader>d"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#show_call_signatures = "1"

    " syntastic
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_auto_loc_list=1
" }

" Source a local configuration file if available.
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
