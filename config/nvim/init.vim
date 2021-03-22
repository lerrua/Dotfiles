" Vim-Plug auto install
if empty(glob(('~/.config/nvim/autoload/plug.vim')))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'mhartington/oceanic-next'
  Plug 'wadackel/vim-dogrun'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sleuth'
  Plug 'w0rp/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
  Plug 'terryma/vim-multiple-cursors'
  Plug 'wincent/terminus'
  Plug 'sheerun/vim-polyglot'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

colorscheme dogrun

let mapleader = ","                                             " set leader shortcut to a comma

set t_Co=256                                                    " display 256 colors
set fileformats=unix,dos,mac
set number                                                      " show line numbers on the sidebar
set showtabline=2
set showbreak=↪                                                 " show arrow at breaking
set hidden                                                      " allow buffer switching without saving
set updatetime=250                                              " pretty much just so gittgutter will update quickly
set clipboard=unnamed,unnamedplus                               " set clipboard
set cursorline                                                  " highlight current line
set cursorcolumn                                                " highlight current column
set mouse=a                                                     " enable mouse use
set expandtab                                                   " convert tabs to spaces
set tabstop=2                                                   " indent using two spaces
set shiftwidth=2                                                " when shifting, indent using four spaces
set lazyredraw                                                  " don’t update screen during macro and script execution
set noshowmode
set pumblend=15                                                 " Use cool floating wildmenu options
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern
set wildignore+=node_modules,DS_Store,vendor
set shortmess+=A                                                " avoid locking popup messages
set cmdheight=1

set backup
set backupdir=~/.cache/nvim                                     " directory to store backup files
set directory=~/.cache/nvim                                     " directory to store swap files
set updatetime=1000                                             " make updates happen faster
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set numberwidth=1
set signcolumn=yes:1                                            " always show signcolumns
set shortmess+=c                                                " don't give |ins-completion-menu| messages

set tabline=%!Tabline()
set statusline=%!StatusLineFormat('active')

hi Comment cterm=italic
" hi Comment cterm=italic guifg=#5C6370 ctermfg=59
hi TabLineSel cterm=reverse gui=reverse
" hi LineNr     ctermbg=NONE guibg=NONE
" hi SignColumn ctermbg=NONE guibg=NONE

" Hidden screen distractions to improve coding
let s:hidden_all = 0
nnoremap <silent> <ENTER> :call ToggleHiddenAll()<CR>

" Toggle cursors line and column on insert mode
let s:toggle_insert = 0
au InsertEnter * silent call ToggleInsertMode()
au InsertLeave * silent call ToggleInsertMode()

" Toggle statusline on active and inactive windows
augroup vimrc-statusline
  autocmd!
  au WinEnter * setl statusline=%!StatusLineFormat('active')
  au WinLeave * setl statusline=%!StatusLineFormat('inactive')
augroup end

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

""" postcss extension
au! BufNewFile,BufRead *.pcss setf css

" Key maps {
" Set working directory
nnoremap <leader>. :cd %:p:h<CR>:pwd<CR>
" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <leader>z :tabnew %<CR>
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
      \	'python': ['flake8'],
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
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
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
nnoremap <silent> <space>ge :GFiles<CR>
nnoremap <silent> <space>e :Files<CR>
nnoremap <silent> <space>f :Rg<CR>
nnoremap <silent> <space>h :History<CR>

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'},
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
  \ 'coc-solargraph',
  \ 'coc-lua',
  \ 'coc-elixir',
\]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
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
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rr <Plug>(coc-refactor)

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
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" } 

" ranger.vim {
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
nnoremap <silent> <F3> :RangerCurrentDirectory<CR>
" }

function! ToggleInsertMode() abort
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
    set nonumber
    set nocursorcolumn
    set nocursorline
    set noruler
    set noshowcmd
    set laststatus=0
    set showtabline=0
    set signcolumn=no
    execute 'GitGutterSignsToggle'
  else
    let s:hidden_all = 0
    set number
    set cursorcolumn
    set cursorline
    set ruler
    set showcmd
    set laststatus=2
    set showtabline=2
    set signcolumn=yes:1
    execute 'GitGutterSignsToggle'
  endif
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
    let s .= (tab == tabpagenr() ? '%#TermCursor#' : '%#TabLine#')
    let s .= (tab == tabpagenr() ? ' %{WebDevIconsGetFileTypeSymbol()}' : '')
    let s .= (bufname != '' ? ' '. fnamemodify(bufname, ':t') . ' ' : ' No Name ')

    if bufmodified
      let s .= '[] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction

if filereadable(glob("~/.config/nvim/statusline.vim"))
  source ~/.config/nvim/statusline.vim
endif
