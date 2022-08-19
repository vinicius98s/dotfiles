vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		local luasnip = require("luasnip")
		if luasnip.expand_or_jumpable() then
			luasnip.unlink_current()
		end
	end,
})
