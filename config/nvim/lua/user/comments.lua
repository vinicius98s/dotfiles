local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local ts_status_ok, ts_context_comment = pcall(require, "ts_context_commentstring")
if not ts_status_ok then
	return
end

ts_context_comment.setup({})
vim.g.skip_ts_context_commentstring_module = true

comment.setup({
	toggler = {
		line = "<C-_>",
	},
	opleader = {
		line = "<C-_>",
	},
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
