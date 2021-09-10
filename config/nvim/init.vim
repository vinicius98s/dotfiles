runtime ./plug.vim
runtime ./bindings.vim
runtime ./nvim-tree.vim
runtime ./themes.vim

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:dashboard_default_executive ='fzf'

set completeopt+=preview
set hidden
set number
set inccommand=split
set smarttab
set ignorecase
set smartcase
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
set encoding=UTF-8
" open new split panes to right and below
set splitright
set splitbelow
" Disable the blinking cursor.
set gcr=a:blinkon0

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

