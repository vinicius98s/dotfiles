local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = " " },
		{ name = "DiagnosticSignWarn", text = " " },
		{ name = "DiagnosticSignHint", text = " " },
		{ name = "DiagnosticSignInfo", text = " " },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "", spacing = 6 })
	end

	vim.diagnostic.config({
		virtual_text = { spacing = 6, prefix = "" },
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = false,
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua Show_documentation()<CR>", opts)
	function Show_documentation()
		local status_ok, saga_hover = pcall(require, "lspsaga.hover")
		if status_ok then
			saga_hover.render_hover_doc()
		else
			vim.lsp.buf.hover()
		end
	end

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.cmd([[ command! Format execute "lua vim.lsp.buf.formatting()" ]])
end

M.on_attach = function(client, bufnr)
	client.resolved_capabilities.document_formatting = false
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
	M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

return M
