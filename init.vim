call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'itchyny/lightline.vim'
Plug 'flrnd/candid.vim'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'fatih/vim-go'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'joshdick/onedark.vim' 
" Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
" Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'matze/vim-move'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Open files and global search
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<cr>

" Navigate between panels with ALT+{H,J,K,L}
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
nmap <C-b> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NerdTreeMinimalUI = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" sync open file with NERDTree
" Check if NERDTree is open or active
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
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet'
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

let g:material_theme_style = 'ocean'
let g:material_terminal_italics = 1
colorscheme material

" colorscheme candid

let g:NERDSpaceDelims = 2

" Clear highlight search on escape
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

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
" open new split panes to right and below
set splitright
set splitbelow
