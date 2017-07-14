set noeb vb t_vb=

" This stops Vim from redrawing the screen during complex operations and
" results
" " in much smoother looking plugins.
" set lazyredraw

" reload files when they change on disk (e.g., git checkout)
set autoread

" set cursorline

" augroup CursorLine
" 	au!
" 	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
" 	au WinLeave * setlocal nocursorline
" augroup END

" vim-devicons
let g:airline_powerline_fonts = 1

" Close NERDTree automatically after opening a file with it.
let g:NERDTreeQuitOnOpen = 1

" Show hidden files by default.
let NERDTreeShowHidden = 1

" " enable mouse use
" set mouse=a

if !has('nvim')
    set ttymouse=xterm2
endif

" jedi-vim setings tabs over buffers
let g:jedi#use_tabs_not_buffers=1

" ALE
let g:ale_linters = {'go': ['gometalinter']}
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ''

highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" defaul gui font
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h13

" perfomance issues
" set nocursorcolumn
" set nocursorline
" set norelativenumber
" set ttyfast
" syntax sync minlines=256"

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline_left_sep = ''
" let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
let g:airline_right_sep = ''
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

" white theme as default
" let g:airline_theme = 'one'
" colorscheme one
" set background=light

colorscheme apprentice
let g:airline_theme = 'lucius'
set background=dark

" function to toggle light/dark themes
function! ChangeDefaultTheme(color)
	if a:color == "light"
		colorscheme one
		let g:airline_theme = "one"
		set background=light
	else
		colorscheme apprentice
		let g:airline_theme = 'lucius'
		set background=dark
	endif
	redraw!
endfunction

map <F9> :call ChangeDefaultTheme("dark")<CR>
map <F10> :call ChangeDefaultTheme("light")<CR>


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
if has('nvim')
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
endif

" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1
let g:deoplete#max_menu_width = 0

" Set the Delve backend.
let g:delve_backend = "native"
