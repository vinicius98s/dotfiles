call plug#begin()

" Themes
" Plug 'projekt0n/github-nvim-theme'
" Plug 'ful1e5/onedark.nvim'
" Plug 'marko-cerovac/material.nvim'
" Plug 'ayu-theme/ayu-vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
" Plug 'neovim/nvim-lspconfig'
" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'glepnir/lspsaga.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'elixir-editors/vim-elixir'

" Git
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Lualine
Plug 'hoob3rt/lualine.nvim'

" Telescope
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/plenary.nvim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'kyazdani42/nvim-web-devicons'

" Buffers, files and navigation
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'qpkorr/vim-bufkill'
Plug 'christoomey/vim-tmux-navigator'

" Appearance
Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/dashboard-nvim'

" Comments
Plug 'preservim/nerdcommenter'

" Moving lines
Plug 'sk1418/Join'

call plug#end()
