" vim-plug auto install
if empty(glob(('~/.config/nvim/autoload/plug.vim')))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
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
    \}
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'w0rp/ale'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
call plug#end()

" base16
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256  					                " Access colors present in 256 colorspace
    source ~/.vimrc_background
endif

set t_Co=256                                                    " display 256 colors
set number                                                      " show line numbers on the sidebar
set title 							                            " set the window’s title, reflecting the file currently being edited
set hidden                                                      " allow buffer switching without saving
set updatetime=250  						                    " pretty much just so gittgutter will update quickly
set clipboard=unnamed,unnamedplus 				                " set clipboard
set cursorline 							                        " highlight current line
set mouse=a 							                        " enable mouse use
set expandtab 							                        " convert tabs to spaces
set tabstop=4 							                        " indent using four spaces
set shiftwidth=4 						                        " when shifting, indent using four spaces
set lazyredraw 							                        " don’t update screen during macro and script execution
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern
set backupdir=~/.cache/nvim                                     " directory to store backup files

set statusline=\ %{WebDevIconsGetFileTypeSymbol()}
set statusline+=\ %f
set statusline+=\ %h%w%m%r
set statusline+=\ 
set statusline+=\ %{fugitive#head()}
set statusline+=\ %=
set statusline+=\ %(%l,%c%V\ %Y\ %=\ %P%)
set statusline+=\ %{LinterStatus()}

let mapleader = ","						                        " set leader shortcut to a comma

" ALE
let g:ale_linters = {
\	'go': ['go build', 'go vet', 'golint'],
\	'python': ['flake8']
\}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" fzf.vim
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>f :Ag<CR>
set grepprg=ag\ --nogroup\ --nocolor
set grepformat=%f:%l:%c:%m,%f:%l:%m

" confortable-motion
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" netrw
nnoremap <silent> <F3> :Lexplore<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Mappings
nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>                        " set working directory

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Copy/Paste/Cut
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

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
