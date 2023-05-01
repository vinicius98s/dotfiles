local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	char = " ",
	context_char = "▏",
	show_current_context = true,
	use_treesitter = true,
	use_treesitter_scope = false,
	show_first_indent_level = true,
	show_trailing_blankline_indent = false,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"text",
	},
})
