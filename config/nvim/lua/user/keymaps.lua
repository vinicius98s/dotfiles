local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Nvimtree
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>e", ":bn<CR>", opts)
keymap("n", "<leader>w", ":bp<CR>", opts)
keymap("n", "<leader>q", ":Bdelete<CR>", opts)
keymap("n", "<leader>x", ":%bd<CR>", opts)

-- These will make it so that going to the next one in a
-- search will center on the line it's found in.
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Split windows
keymap("n", "sd", ":split<CR>", opts)
keymap("n", "ss", ":vsplit<CR>", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Delete without yank
keymap("n", "<C-d>", '"_d', opts)

-- Clear highlight search on escape
keymap("n", "<ESC>", ":nohlsearch<Return><ESC>", opts)

-- Find files/live grep
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<CR>", opts)

-- Insert --
-- Press jj fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("v", "<leader>j", "<ESC>", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Command --
-- No one is really happy until you have this shortcuts (thanks vim-boostrap)
vim.cmd "cnoreabbrev W! w!"
vim.cmd "cnoreabbrev Q! q!"
vim.cmd "cnoreabbrev Qall! qall!"
vim.cmd "cnoreabbrev Wq wq"
vim.cmd "cnoreabbrev Wa wa"
vim.cmd "cnoreabbrev wQ wq"
vim.cmd "cnoreabbrev WQ wq"
vim.cmd "cnoreabbrev W w"
vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Qall qall"
vim.cmd "cnoreabbrev Qa qa"

