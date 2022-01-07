require"fzf-lua".setup {
  preview_layout = "flex",
  files = {
    prompt = "❯ ",
    file_icons = true,
    color_icons = true,
    cmd = 'fd --type f --hidden --follow --exclude .git',
  },
  grep = {
    prompt = "❯ ",
    file_icons = true,
    color_icons = true,
  },
  previewers = {
    bat = {
      cmd = "bat",
      args = "--style=numbers,changes --color always",
      theme = "OneHalfDark",
    }
  }
}
