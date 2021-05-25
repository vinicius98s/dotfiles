call plug#begin()

" Themes
" Plug 'drewtempelmeyer/palenight.vim'
" Plug 'aonemd/quietlight.vim'
" Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Plug 'Rigellute/shades-of-purple.vim'
" Plug 'joshdick/onedark.vim' 
" Plug 'flrnd/candid.vim'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'ayu-theme/ayu-vim'

" Languages and LSP
" Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
" Plug 'reasonml-editor/vim-reason-plus'
" Plug 'jparise/vim-graphql'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Toggle commenter
Plug 'preservim/nerdcommenter'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'

" Find files
Plug 'ctrlpvim/ctrlp.vim'

" Move lines
Plug 'matze/vim-move'

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" Appearence
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Open files and global search
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<cr>

" Navigate between panels with ALT/CTRL+{H,J,K,L}
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

let mapleader = " "

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

" Close buffer
noremap <leader>c :bd!<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <leader>t<leader> :tabnext
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
let g:lasttab = 1
nmap <leader>lt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Terminal
nnoremap <silent> <leader>sh :terminal<CR>

" No one is really happy until you have this shortcuts (thanks vim-boostrap)
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Git
noremap <leader>g :G<CR>
noremap <leader>gj :diffget //3<CR>
noremap <leader>gf :diffget //2<CR>
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gsh :Gpush<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Gremove<CR>

" NerdTree
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

nmap <C-b> :call NERDTreeToggleAndRefresh()<CR>

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
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

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" Airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

let g:move_key_modifier = 'C'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ale_completion_autoimport = 1
let g:ale_fixers = { 'elixir': ['mix_format'], 'javascript': ['prettier', 'eslint'] }

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Themes
syntax on
set termguicolors
set background=dark

let ayucolor="dark"
colorscheme ayu

" colorscheme palenight
" let g:airline_theme = "palenight"
" let g:palenight_terminal_italics=1

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

" Bind escape
inoremap jj <esc>
vnoremap <leader>j <esc>

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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
" Disable the blinking cursor.
set gcr=a:blinkon0

au TermEnter * setlocal scrolloff=0
au TermLeave * setlocal scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

