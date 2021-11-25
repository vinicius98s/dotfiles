let mapleader = " "

" Bind escape
inoremap jj <esc>
vnoremap <leader>j <esc>

" Navigate between panels with CTRL+{H,J,K,L}
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
cnoreabbrev Qa qa

" Split window
nmap sd :split<Return><C-w>w
nmap ss :vsplit<Return><C-w>w

" Select all
nmap <C-a> gg<S-v>G

" Delete without yank
nnoremap <C-d> "_d

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Go to definition
nmap <silent> gd <Plug>(coc-definition)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Clear highlight search on escape
nnoremap <esc> :nohlsearch<return><esc>

" Fzf
nnoremap <C-p> :FzfLua files<cr>
nnoremap <C-f> :FzfLua live_grep<cr>
nnoremap <C-o> :FzfLua buffers<cr>

" Buffer navigation
noremap <leader>w :bp<cr>
noremap <leader>e :bn<cr>
noremap <leader>q :BD<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Toggle comments
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>

" Git
noremap <leader>g :G<CR>
noremap <leader>gj :diffget //2<CR>
noremap <leader>gk :diffget //3<CR>
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gca :Git commit --amend<CR>
noremap <leader>gps :Git push<CR>
noremap <leader>gpsf :Git push --force<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :GRemove<CR>

" NvimTree
nnoremap <C-b> :NvimTreeToggle<CR>
