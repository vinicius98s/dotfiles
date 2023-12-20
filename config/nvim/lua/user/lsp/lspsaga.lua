local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.setup({
	ui = {
		code_action = " ",
	},
	lightbulb = {
		enable = true,
		virtual_text = false,
	},
})
