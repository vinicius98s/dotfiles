call plug#begin()

Plug 'jparise/vim-graphql'
Plug 'itchyny/lightline.vim'
Plug 'flrnd/candid.vim'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'joshdick/onedark.vim' 
" Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
" Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'matze/vim-move'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <C-b> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

nmap <silent> gd <Plug>(coc-definition)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

let g:move_key_modifier = 'C'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

syntax on
set background=dark
set termguicolors

let g:lightline = { 'colorscheme': 'candid' }
let g:candid_color_store = {
    \ "black": {"gui": "#0A0A16", "cterm256": "0"},
    \}
colorscheme candid

set relativenumber
set hidden
set number
set inccommand=split
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
set encoding=UTF-8
