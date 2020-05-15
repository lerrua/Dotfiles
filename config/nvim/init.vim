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
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'ap/vim-css-color'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'w0rp/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set showtabline=2
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
set wildignore+=node_modules,DS_Store,vendor
set shortmess+=A                                                " avoid locking popup messages
set cmdheight=1

set backup
set backupdir=~/.cache/nvim                                     " directory to store backup files
set directory=~/.cache/nvim                                     " directory to store swap files
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set numberwidth=1
set signcolumn=yes:1                                              " always show signcolumns
set shortmess+=c                                                " don't give |ins-completion-menu| messages

set tabline=%!Tabline()
set statusline=%!StatusLine()

hi Comment cterm=italic
hi TabLineSel cterm=italic

" Hidden screen distractions to improve coding
let s:hidden_all = 0
nnoremap <silent> <ENTER> :call ToggleHiddenAll()<CR>

" Toggle cursors line and column on insert mode
let s:toggle_insert = 0
au InsertEnter * silent call ToggleInsertMode()
au InsertLeave * silent call ToggleInsertMode()

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

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
    let g:ale_set_highlights = 0
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_sign_error = ''
    let g:ale_sign_warning = ''
    let g:ale_sign_ok = 'ﲏ'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 'never'
    " jump to prev/next quickfix results
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }

" gitgutter {
    let g:gitgutter_sign_added = ''
    let g:gitgutter_sign_modified = ''
    let g:gitgutter_sign_removed = ''
    let g:gitgutter_sign_removed_first_line = ''
    let g:gitgutter_sign_modified_removed = ''
" }

" fzf.vim {
    nnoremap <silent> <space>b :Buffers<CR>
    nnoremap <silent> <space>e :FZF -m<CR>
    nnoremap <silent> <space>f :Rg<CR>
    nnoremap <silent> <space>h :History<CR>
    " set grepprg=ag\ --nogroup\ --nocolor
    " set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Customize fzf colors to match color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " ripgrep
    if executable('rg')
      let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
      set grepprg=rg\ --vimgrep

      command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

      " Likewise, Files command with preview window
      command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    endif

    " Hide fzf statusline
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler  
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

" coc.nvim {
    let g:coc_global_extensions = [
        \ 'coc-snippets',
        \ 'coc-pairs',
        \ 'coc-diagnostic',
        \ 'coc-tsserver',
        \ 'coc-json',
        \ 'coc-html',
        \ 'coc-tag',
        \ 'coc-emmet',
        \ 'coc-angular',
        \ 'coc-rls',
        \ 'coc-python',
        \ 'coc-pyls',
        \ 'coc-lua',
        \]

    if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
        let g:coc_global_extensions += ['coc-prettier']
    endif

    if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
        let g:coc_global_extensions += ['coc-eslint']
    endif
    " Use <c-space> for trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup coc-vimrc-group
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` for fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" } 

" vim-delve {
    let g:delve_backend = "native"                              " Go debugger
    au FileType go nmap <buffer> <silent> <F5> :DlvDebug<CR>
    au FileType go nmap <buffer> <silent> <F6> :DlvToggleBreakpoint<CR>
" }

" ranger.vim {
    let g:ranger_replace_netrw = 1
    let g:ranger_map_keys = 0
    let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
    nnoremap <silent> <F3> :Ranger<CR>
" }

" statusline functions {
    let s:mode_map = {
          \ 'n':      ' NORMAL ',
          \ 'no':     ' NO     ',
          \ 'v':      ' V-CHAR ',
          \ 'V':      ' V-LINE ',
          \ "\<C-v>": ' V-BLCK ',
          \ 's':      ' S-CHAR ',
          \ 'S':      ' S-LINE ',
          \ "\<C-s>": ' S-B    ',
          \ 'i':      ' INSERT ',
          \ 'ic':     ' I-COMP ',
          \ 'ix':     ' I-COMP ',
          \ 'R':      ' R      ',
          \ 'Rc':     ' R-COMP ',
          \ 'Rv':     ' R-VIRT ',
          \ 'Rx':     ' R-COMP ',
          \ 'c':      ' C-LINE ',
          \ 'cv':     ' EX     ',
          \ 'ce':     ' EX     ',
          \ 'r':      ' ENTER  ',
          \ 'rm':     ' MORE   ',
          \ 'r?':     ' ?      ',
          \ '!':      ' SHELL  ',
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
            return printf(' %s', branch_name)
        endif
        return ''
    endfunction

    function! FilenameStatusline()
        let l:filetype_symbol = WebDevIconsGetFileTypeSymbol()
        let l:filetype_name = expand('%:t')
        return printf(' %s %s ', filetype_symbol, filetype_name)
    endfunction

    function! ToggleInsertMode()
        if s:toggle_insert  == 0
            let s:toggle_insert = 1
            set nocursorcolumn
            set nocursorline
        else
            let s:toggle_insert = 0
            set cursorcolumn
            set cursorline
        endif
    endfunction

    function! ToggleHiddenAll()
        if s:hidden_all  == 0
            let s:hidden_all = 1
            set noshowmode
            set nonumber
            set nocursorcolumn
            set nocursorline
            set noruler
            set laststatus=0
            set noshowcmd
        else
            let s:hidden_all = 0
            set showmode
            set number
            set cursorcolumn
            set cursorline
            set ruler
            set laststatus=2
            set showcmd
        endif
    endfunction
" }

" statusline
function! StatusLine()
    let s = ''
    let s .= '  '
    let s .= ''                                             " section separator
    let s .= ' %{GitBranchStatusline()} '                      " display git branch label
    " let s .=\ 
    " let s .=\ %{expand('%:p:h')}                            " display path directory
    " let s .=\                                               " white space
    " let s .=%1*\%{FilenameStatusline()}                     " display git branch label
    let s .= ' %{ReadOnlyStatusline()} '                        " display read only icon
    let s .= ' %{PasteStatusline()}%* '                         " display paste mode icon
    let s .= '%='                                            " split point for left and right groups
    let s .= '%l'                                            " row number
    let s .= ''                                              " colon separator
    let s .= '%v'                                              " column number
    let s .= ' '                                              " line number icon
    let s .= ''                                             " section separator
    let s .= ' %{WebDevIconsGetFileFormatSymbol()} '           " file format icon
    let s .= '%{&fileencoding?&fileencoding:&encoding}'       " current file encoding
    let s .= '  '                                             " section separator
    let s .= ' %{LinterStatusline()} '                         " linter status
    let s .= ' '                                              " section separator
    let s .= '%#TermCursor#'
    let s .= '%{VimModeStatusline()}'                        " display actual vim mode
    return s
endfunction

" tabline 
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? ''. fnamemodify(bufname, ':t') . ' ' : 'No Name ')
    let s .= (tab == tabpagenr() ? '%{WebDevIconsGetFileTypeSymbol()} ' : '')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
