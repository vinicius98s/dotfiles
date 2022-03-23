local status_ok, blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.opt.list = true

blankline.setup {
  space_char_blankline = " ",
  show_current_context = true,
}
