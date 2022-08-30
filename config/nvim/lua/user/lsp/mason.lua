local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver", "eslint" },
	automatic_installation = true,
})

local handlers = require("user.lsp.handlers")
local lspconfig = require("lspconfig")
local util = lspconfig.util

util.default_config = vim.tbl_extend("force", util.default_config, {
	capabilities = handlers.capabilities,
	on_attach = handlers.on_attach,
})

lspconfig.sumneko_lua.setup({})
lspconfig.tsserver.setup({})

local jsonls_config = require("user.lsp.settings.jsonls")
lspconfig.jsonls.setup(jsonls_config)

local rust_analyzer_config = require("user.lsp.settings.rust-analyzer")
lspconfig.rust_analyzer.setup(rust_analyzer_config)