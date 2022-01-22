require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lualine"
require "user.lsp"
require "user.treesitter"
require "user.comments"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"

vim.opt.list = true

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
}

