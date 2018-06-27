" Vim-Plug auto install
if empty(glob(('~/.config/nvim/autoload/plug.vim')))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'chriskempson/base16-vim'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'yuttie/comfortable-motion.vim'
    Plug 'tpope/vim-sensible'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'w0rp/ale'
    Plug 'maralla/completor.vim'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': 'go'}
    Plug 'sebdah/vim-delve', {'for': 'go'}
    Plug 'buoto/gotests-vim', {'for': 'go'}
call plug#end()

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256                                    " access colors present in 256 colorspace
    source ~/.vimrc_background                                  " activate base16 colorscheme
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
set cursorcolumn                                                " highlight current column
set mouse=a                                                     " enable mouse use
set expandtab                                                   " convert tabs to spaces
set tabstop=4                                                   " indent using four spaces
set shiftwidth=4                                                " when shifting, indent using four spaces
set lazyredraw                                                  " don’t update screen during macro and script execution
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern
set shortmess+=A                                                " avoid locking popup messages
set backup
set backupdir=~/.cache/nvim                                     " directory to store backup files
set directory=~/.cache/nvim                                     " directory to store swap files
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set statusline=
set statusline+=%#StatusLineNC#                                 " switch to StatusLineNC highlight
set statusline+=\ 
set statusline+=\ %{expand('%:p:h')}                            " display path directory
set statusline+=\ %*                                            " switch back to statusline highlight
set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}             " filetype icon
set statusline+=\ %{expand('%:t')}                              " display filename
set statusline+=\                                              " left separator 
set statusline+=\ %{GitBranchStatusline()}                      " display git branch label
set statusline+=\%{ReadOnlyStatusline()}                        " display read only icon
set statusline+=\%{ModifiedStatusline()}                        " display modified file icon
set statusline+=\%{PasteStatusline()}                           " display paste mode icon
set statusline+=\%{VimModeStatusline()}                         " display actual vim mode 
set statusline+=\ %=                                            " split point for left and right groups
set statusline+=%l                                              " row number
set statusline+=\                                              " colon separator
set statusline+=%v                                              " column number
set statusline+=\                                              " line number icon
set statusline+=\ %{WebDevIconsGetFileFormatSymbol()}           " file format icon
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}      " current file encoding
set statusline+=\ %#StatusLineNC#                               " switch to StatusLineNC highlight
set statusline+=\ %{LinterStatusline()}                         " linter status
set statusline+=\%*                                             " switch back to statusline highlight

hi Comment cterm=italic

" Key maps {
    " Set working directory
    nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>
    " Tabs
    nnoremap <Tab> gt
    nnoremap <S-Tab> gT
    nnoremap <silent> <S-t> :tabnew<CR>
    " Copy/Paste/Cut
    set pastetoggle=<F2>                                        " pasting text unmodified from other applications
    noremap YY "+y<CR>
    noremap <leader>p "+gP<CR>
    noremap XX "+x<CR>
    " Vmap for maintain Visual Mode after shifting > and <
    vmap < <gv
    vmap > >gv
    " Clean search highlight
    nnoremap <silent> <leader><space> :noh<CR>
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

" vim-go {
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
" }
"
" completor.vim {
    let g:completor_gocode_binary = $GOPATH.'/bin/gocode'       " Go autocomplete
" } 

" vim-delve {
    let g:delve_backend = "native"                              " Go debugger
    nmap <silent> <F5> :DlvDebug<CR>
    nmap <silent> <F6> :DlvToggleBreakpoint<CR>
" }

" ranger.vim {
    let g:ranger_replace_netrw = 1                              " open ranger when vim open a directory
    nnoremap <silent> <F3> :Ranger<CR>
" }

function! LinterStatusline() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return printf('✖ %d  %d ', all_errors, all_non_errors)
endfunction

function! ModifiedStatusline()
    if &modified == 1
        return '  '
    endif
    return ''
endfunction

function! ReadOnlyStatusline()
    if &readonly == 1
        return '  '
    endif
    return ''
endfunction

function! PasteStatusline()
    if &paste == 1
        return '  '
    endif
    return ''
endfunction

function! VimModeStatusline()
    if mode() == 'i'
        return '  '
    endif
    return ''
endfunction

function! GitBranchStatusline()
    let l:branch_name = fugitive#head()
    if l:branch_name != ""
        return printf(' %s ', branch_name)
    endif
    return ''
endfunction
