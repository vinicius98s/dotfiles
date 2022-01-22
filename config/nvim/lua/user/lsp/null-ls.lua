local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
  sources = {
    formatting.prettier,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    diagnostics.flake8,
    diagnostics.eslint,
    code_actions.eslint
  },
}
