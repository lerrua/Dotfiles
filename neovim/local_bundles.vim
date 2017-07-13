" custom themes
Plug 'reedes/vim-colors-pencil'
Plug 'nickburlett/vim-colors-stylus'
Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'romainl/Apprentice'

" neovim auto-complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" icons
Plug 'ryanoasis/vim-devicons'

" ALE instead of syntastic
Plug 'w0rp/ale'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" python plugins
Plug 'chiel92/vim-autoformat'
Plug 'jmcantrell/vim-virtualenv'
Plug 'alfredodeza/pytest.vim'
Plug 'zchee/deoplete-jedi'

" tmux
Plug 'benmills/vimux'

" git
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" golang
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'sebdah/vim-delve'

" funny things
Plug 'koron/nyancat-vim'
