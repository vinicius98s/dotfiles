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
	ensure_installed = { "lua_ls", "rust_analyzer", "eslint" },
	automatic_installation = true,
})

local handlers = require("user.lsp.handlers")
local lspconfig = require("lspconfig")
local util = lspconfig.util

util.default_config = vim.tbl_extend("force", util.default_config, {
	capabilities = handlers.capabilities,
	on_attach = handlers.on_attach,
})

lspconfig.lua_ls.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.eslint.setup({})

local jsonls_config = require("user.lsp.settings.jsonls")
lspconfig.jsonls.setup(jsonls_config)

local tt_ok, tt = pcall(require, "typescript-tools")
if not tt_ok then
	vim.notify("typescript lsp not installed")
	return
end

tt.setup({})

local rt_ok, rt = pcall(require, "rust-tools")
if not rt_ok then
	vim.notify("rust lsp not installed")
	return
end
local rust_analyzer_config = require("user.lsp.settings.rust-analyzer")
rt.setup(rust_analyzer_config)

local yaml_ok, yaml = pcall(require, "yaml-companion")
if not yaml_ok then
	vim.notify("yaml lsp not installed")
	return
end
lspconfig.yamlls.setup(yaml.setup({}))
