set noeb vb t_vb=

set termguicolors

" simple todo list
command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" set clipboard
set clipboard=unnamed,unnamedplus

" reload files when they change on disk (e.g., git checkout)
set autoread

" Highlight current line
set cursorline

" vim-devicons
let g:airline_powerline_fonts = 1

" Close NERDTree automatically after opening a file with it.
let g:NERDTreeQuitOnOpen = 1

" Show hidden files by default.
let NERDTreeShowHidden = 1

" Hidden bookmarks by default.
let NERDTreeShowBookmarks=0
nmap <F10> :NERDTreeFromBookmark<space>
" Open Terminal on custom buffers
nmap <F9> :Term<CR>
nmap <F8> :VTerm<CR>

" " enable mouse use
set mouse=a

let g:jedi#use_tabs_not_buffers=1

" ALE
let g:ale_linters = {'go': ['go build', 'go vet', 'golint'], 'rust': ['rustc', 'rls'], 'python': ['flake8']}
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ''

highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_rust_cargo_check_all_targets = 0
let g:rustfmt_autosave = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep = ''
" let g:airline_left_sep = ''
" let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
" let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:webdevicons_enable_airline_statusline = 1

let g:airline_mode_map = {
			\ '__' : '-',
			\ 'n'  : 'N',
			\ 'i'  : 'I',
			\ 'R'  : 'R',
			\ 'c'  : 'C',
			\ 'v'  : 'V',
			\ 'V'  : 'V',
			\ '' : 'V',
			\ 's'  : 'S',
			\ 'S'  : 'S',
			\ '' : 'S',
			\ }

" FZF
set rtp+=/usr/local/opt/fzf

nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Ag<CR>

" Zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Resize panes
nnoremap <silent> <leader><Right> :vertical resize +5<cr>
nnoremap <silent> <leader><Left> :vertical resize -5<cr>
nnoremap <silent> <leader><Up> :resize +5<cr>
nnoremap <silent> <leader><Down> :resize -5<cr>

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" auto pep8
let g:formatter_yapf_style = 'pep8'
noremap <F8> :Autoformat<CR>

" create if/toggle before commit
"
" colorscheme one
" let g:airline_theme = 'one'
" set background=light
let g:nord_comment_brightness = 20
colorscheme nord
let g:airline_theme = 'nord'
" colorscheme gruvbox
" let g:airline_theme = 'gruvbox'
" set background=dark
" colorscheme one
" let g:airline_theme = 'one'
" set background=light

" Vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vo :VimuxTogglePane<CR>
map <Leader>vx :VimuxInterruptRunner<CR>

" Function to make tmux zoom its runner pane.
function! VimuxZoomRunner()
	call VimuxInspectRunner()
	call system("tmux resize-pane -Z")
endfunction

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" Golang
let g:deoplete#sources#go#pointer = 1
" Set the Delve backend.
let g:delve_backend = "native"
nmap <silent> <F5> :DlvDebug<CR>
nmap <silent> <F6> :DlvToggleBreakpoint<CR>

" Rust
" https://github.com/sebastianmarkow/deoplete-rust
let g:racer_cmd = "$HOME/.cargo/bin/racer"
" let g:deoplete#sources#rust#racer_binary="$HOME/.cargo/bin/racer"
let g:deoplete#sources#rust#racer_binary='/home/leroy/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
let g:deoplete#sources#rust#documentation_max_height=20

augroup rust-mapping
    autocmd!
    autocmd filetype rust nmap <buffer> gd <Plug>DeopleteRustGoToDefinitionTab
    autocmd filetype rust nmap <buffer> K <plug>DeopleteRustShowDocumentation
augroup end

" ranger
let g:ranger_map_keys = 0
map <leader>rr :Ranger<CR>

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
