" Vim-Plug auto install
if empty(glob(('~/.config/nvim/autoload/plug.vim')))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
    Plug 'chriskempson/base16-vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'yuttie/comfortable-motion.vim'
    Plug 'tpope/vim-sensible'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf', {
    \	'dir': '~/.fzf', 'do': './install --all'
    \ }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'w0rp/ale'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
    Plug 'Shougo/deoplete.nvim', {
    \   'do': ':UpdateRemotePlugins'
    \ }
    Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
    Plug 'zchee/deoplete-go', { 'do': 'make'}
    Plug 'sebdah/vim-delve'
    Plug 'buoto/gotests-vim' 
call plug#end()

" base16 colorscheme
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256                                    " Access colors present in 256 colorspace
    source ~/.vimrc_background
endif

let mapleader = ","                                             " set leader shortcut to a comma

set t_Co=256                                                    " display 256 colors
set fileformats=unix,dos,mac
set number                                                      " show line numbers on the sidebar
set title                                                       " set the window’s title, reflecting the file currently being edited
set showbreak=↪                                                 " show arrow at breaking
set hidden                                                      " allow buffer switching without saving
set updatetime=250                                              " pretty much just so gittgutter will update quickly
set clipboard=unnamed,unnamedplus                               " set clipboard
set cursorline                                                  " highlight current line
set mouse=a                                                     " enable mouse use
set expandtab                                                   " convert tabs to spaces
set tabstop=4                                                   " indent using four spaces
set shiftwidth=4                                                " when shifting, indent using four spaces
set lazyredraw                                                  " don’t update screen during macro and script execution

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern

set backup
set backupdir=~/.cache/nvim                                     " directory to store backup files
set directory=~/.cache/nvim                                     " directory to store swap files
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload

set statusline=\ %{WebDevIconsGetFileTypeSymbol()}
set statusline+=\ %f
set statusline+=\ %h%w%m%r
set statusline+=\»
set statusline+=\ 
set statusline+=\ %{fugitive#head()}
set statusline+=\ %=
set statusline+=\ 
set statusline+=\ %(%l,%c%V\ %Y\ %=\ %P%)
set statusline+=\ «
set statusline+=\ %{LinterStatus()}

highlight Comment cterm=italic

" Key maps {
    " set working directory
    nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>
    " Tabs
    nnoremap <Tab> gt
    nnoremap <S-Tab> gT
    nnoremap <silent> <S-t> :tabnew<CR>
    " Copy/Paste/Cut
    noremap YY "+y<CR>
    noremap <leader>p "+gP<CR>
    noremap XX "+x<CR>
    " Vmap for maintain Visual Mode after shifting > and <
    vmap < <gv
    vmap > >gv
" }

" netrw {
    nnoremap <silent> <F3> :Lexplore<CR>
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 2
    let g:netrw_altv = 1
    let g:netrw_winsize = 25
    let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
    autocmd FileType netrw set nolist
" }

" ALE {
    let g:ale_linters = {
    \	'go': ['go build', 'go vet', 'golint'],
    \	'python': ['flake8']
    \}
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign
    let g:ale_sign_error = '✖'
    let g:ale_sign_warning = ''
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 'never'
    " jump to prev/next quickfix results
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }

" fzf.vim {
    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>e :FZF -m<CR>
    nnoremap <silent> <leader>f :Ag<CR>
    set grepprg=ag\ --nogroup\ --nocolor
    set grepformat=%f:%l:%c:%m,%f:%l:%m
" }

" confortable-motion {
    noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
    noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
" }

" deoplete.nvim {
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#go#pointer = 1                       " Go autocomplete
" } 

" vim-delve {
    let g:delve_backend = "native"                              " Go debugger
    nmap <silent> <F5> :DlvDebug<CR>
    nmap <silent> <F6> :DlvToggleBreakpoint<CR>
" }

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? ' ' : printf(
    \   '%d  %d  ',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
