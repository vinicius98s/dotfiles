runtime ./plug.vim
runtime ./bindings.vim
runtime ./nvim-tree.vim
runtime ./themes.vim

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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

