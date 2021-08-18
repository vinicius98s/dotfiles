local lspconfig = require("lspconfig")

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

require'lspconfig'.elixirls.setup{
    cmd = { "$HOME/elixir-ls/language_server.sh" };
}

lspconfig.efm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {"elixir"}
})


