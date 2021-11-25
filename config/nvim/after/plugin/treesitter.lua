require("nvim-treesitter.configs").setup {
  playground = {
    enable = false,
  },
  autotag = {enable = true},
  ignore_install = { "haskell" },
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {enable = true},
  context_commentstring = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }
}
