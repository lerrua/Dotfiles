" custom themes
Plug 'reedes/vim-colors-pencil'
Plug 'nickburlett/vim-colors-stylus'
Plug 'rakr/vim-one'
Plug 'romainl/Apprentice'
Plug 'owickstrom/vim-colors-paramount'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

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
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'sebdah/vim-delve'

" rust
Plug 'sebastianmarkow/deoplete-rust'

" terminal utilities
Plug 'mklabs/split-term.vim'

" ranger file manager
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" funny things
Plug 'koron/nyancat-vim'
