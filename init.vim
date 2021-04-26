call plug#begin()

" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'aonemd/quietlight.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'Rigellute/shades-of-purple.vim'
Plug 'joshdick/onedark.vim' 
Plug 'flrnd/candid.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Elixir
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dense-analysis/ale'
Plug 'lambdalisue/gina.vim'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'jparise/vim-graphql'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'fatih/vim-go'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'matze/vim-move'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Open files and global search
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<cr>

" Navigate between panels with ALT/CTRL+{H,J,K,L}
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

:let mapleader = " "

" tabs
map <leader>t<leader> :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>
nmap <leader>tn :tabnew<CR>
let g:lasttab = 1
nmap <leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" git
nmap <leader>g :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" nerdtree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
nmap <C-b> :call NERDTreeToggleAndRefresh()<CR>

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

let g:NERDTreeWinSize=50
let g:NERDTreeWinPos = "right"
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDSpaceDelims = 2
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && g:NERDTree.IsOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

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

let g:ale_completion_autoimport = 1
let g:ale_fixers = { 'elixir': ['mix_format'], 'javascript': ['prettier', 'eslint'] }

" themes
syntax on
set termguicolors
set background=dark

" colorscheme palenight
" let g:airline_theme = "palenight"
" let g:palenight_terminal_italics=1

let ayucolor="dark"
colorscheme ayu

" let g:airline_theme='onehalfdark'
" colorscheme onehalfdark
" set cursorline

" let g:airline_theme = 'material'
" let g:material_theme_style = 'ocean'
" let g:material_terminal_italics = 1
" colorscheme material 

" colorscheme candid
" let g:candid_color_store = {
    " \ "black": {"gui": "#0A0A16", "cterm256": "0"},
    " \}

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

