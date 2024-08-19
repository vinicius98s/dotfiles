local status_ok, lint = pcall(require, "lint")
if not status_ok then
	return
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
