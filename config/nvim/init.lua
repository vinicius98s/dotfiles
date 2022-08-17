require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lualine"
require "user.lsp"
require "user.treesitter"
require "user.telescope"
require "user.autocommands"
require "user.comments"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.indent_blankline"
require "user.notify"
require "user.alpha"

require("neotest").setup({
  adapters = {
    require("neotest-rust"),
    require("neotest-jest"),
  },
})

