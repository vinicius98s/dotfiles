local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.init_lsp_saga({
	diagnostic_header = { " ", " ", " ", "ﴞ " },
	code_action_icon = "",
	border_style = "rounded",
})
