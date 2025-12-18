-- Normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>e", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search will center on the line it's found in" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search will center on the line it's found in" })

vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape" })

-- Visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Stay in ident mode", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in ident mode", silent = true })

-- Visual Block mode
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move text up", silent = true })
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move text down", silent = true })

vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qall qall")
vim.cmd("cnoreabbrev Qa qa")
