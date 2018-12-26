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
    Plug 'mhinz/vim-startify'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'maralla/completor.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'wincent/terminus'
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries', 'for': 'go'}
    Plug 'sebdah/vim-delve', {'for': 'go'}
    Plug 'buoto/gotests-vim', {'for': 'go'}
    Plug 'sheerun/vim-polyglot'
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
set noshowmode
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
set statusline+=\ 
set statusline+=\ %{expand('%:p:h')}                            " display path directory
set statusline+=\                                               " white space
set statusline+=%1*\%{FilenameStatusline()}                     " display git branch label
set statusline+=\%{ReadOnlyStatusline()}                        " display read only icon
set statusline+=\%{ModifiedStatusline()}                        " display modified file icon
set statusline+=\%{PasteStatusline()}%*                         " display paste mode icon
set statusline+=\ %{GitBranchStatusline()}                      " display git branch label
set statusline+=\ %=                                            " split point for left and right groups
set statusline+=\                                              " section separator
set statusline+=\ %l                                            " row number
set statusline+=\                                              " colon separator
set statusline+=%v                                              " column number
set statusline+=\                                              " line number icon
set statusline+=\                                              " section separator
set statusline+=\ %{WebDevIconsGetFileFormatSymbol()}           " file format icon
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}      " current file encoding
set statusline+=\                                              " section separator
set statusline+=\ %{LinterStatusline()}                         " linter status
set statusline+=\ %{VimModeStatusline()}                        " display actual vim mode

hi Comment cterm=italic
hi User1 cterm=reverse 

" Key maps {
    " Set working directory
    nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>
    " Tabs
    nnoremap <silent> t% :call OpenCurrentAsNewTab()<CR>
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
    " Keep cursor centered into screen
    nnoremap j jzz
    nnoremap k kzz
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
    let g:ale_sign_error = ''
    let g:ale_sign_warning = ''
    let g:ale_sign_ok = 'ﲏ'
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
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_function_arguments = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_auto_type_info = 1
    let g:go_auto_sameids = 1
    augroup VimGo
        au!
        au FileType go nmap <buffer> <leader>i <Plug>(go-info)
        au FileType go nmap <buffer> <leader>gd <Plug>(go-def)
        au FileType go nmap <buffer> <leader>t  <Plug>(go-test)
        au FileType go nmap <buffer> <leader>gt <Plug>(go-coverage-toggle)
        au FileType go nmap <buffer> <leader>d :GoDecls<CR>
        au FileType go nmap <buffer> <leader>dr :GoDeclsDir<CR>
    augroup END
" }

" completor.vim {
    let g:completor_gocode_binary = $GOPATH.'/bin/gocode'       " Go autocomplete
    let g:completor_python_binary = '/usr/bin/python'           " Python autocomplete
" } 

" vim-delve {
    let g:delve_backend = "native"                              " Go debugger
    au FileType go nmap <buffer> <silent> <F5> :DlvDebug<CR>
    au FileType go nmap <buffer> <silent> <F6> :DlvToggleBreakpoint<CR>
" }

" ranger.vim {
    let g:ranger_map_keys = 0
    let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
    nnoremap <silent> <F3> :Ranger<CR>
" }

function! OpenCurrentAsNewTab()
    let l:currentPos = getcurpos()
    tabedit %
    call setpos(".", l:currentPos)
endfunction

" statusline functions {
    let s:mode_map = {
          \ 'n':      ' NORMAL ',
          \ 'no':     ' NO     ',
          \ 'v':      ' V-CHAR ',
          \ 'V':      ' V-LINE ',
          \ "\<C-v>": ' V-BLCK ',
          \ 's':      ' S-CHAR ',
          \ 'S':      ' S-LINE ',
          \ "\<C-s>": ' S-B    ',
          \ 'i':      ' INSERT ',
          \ 'ic':     ' I-COMP ',
          \ 'ix':     ' I-COMP ',
          \ 'R':      ' R      ',
          \ 'Rc':     ' R-COMP ',
          \ 'Rv':     ' R-VIRT ',
          \ 'Rx':     ' R-COMP ',
          \ 'c':      ' C-LINE ',
          \ 'cv':     ' EX     ',
          \ 'ce':     ' EX     ',
          \ 'r':      ' ENTER  ',
          \ 'rm':     ' MORE   ',
          \ 'r?':     ' ?      ',
          \ '!':      ' SHELL  ',
    \ }

    function! VimModeStatusline()
        let l:mode = mode()
        return has_key(s:mode_map, l:mode) ? s:mode_map[l:mode] : ''
    endfunction

    function! LinterStatusline() abort
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error
        let l:all_non_errors = l:counts.total - l:all_errors
        if l:counts.total > 0
            return printf('%s: %d %s: %d', g:ale_sign_error, all_errors, g:ale_sign_warning, all_non_errors)
        endif
        return printf('%s', g:ale_sign_ok)
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

    function! GitBranchStatusline()
        let l:branch_name = fugitive#head()
        if l:branch_name != ""
            return printf(' %s ', branch_name)
        endif
        return ''
    endfunction

    function! FilenameStatusline()
        let l:filetype_symbol = WebDevIconsGetFileTypeSymbol()
        let l:filetype_name = expand('%:t')
        return printf(' %s %s ', filetype_symbol, filetype_name)
    endfunction
" }
