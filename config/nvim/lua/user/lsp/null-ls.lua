local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
-- local diagnostics = null_ls.builtins.diagnostics

local conditional = function(fn)
	local utils = require("null-ls.utils").make_conditional_utils()
	return fn(utils)
end

null_ls.setup({
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ timeout_ms = 10000 })")
		end
	end,
	sources = {
		code_actions.gitsigns,
		formatting.prettier,
		conditional(function(utils)
			return utils.root_has_file("Gemfile")
					and formatting.rubocop.with({
						command = "bundle",
						args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
					})
				or formatting.rubocop
		end),
		-- diagnostics.rubocop,
		formatting.stylua,
		formatting.rustfmt.with({
			extra_args = function(params)
				local Path = require("plenary.path")
				local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

				if cargo_toml:exists() and cargo_toml:is_file() then
					for _, line in ipairs(cargo_toml:readlines()) do
						local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
						if edition then
							return { "--edition=" .. edition }
						end
					end
				end
				-- default edition when we don't find `Cargo.toml` or the `edition` in it.
				return { "--edition=2021" }
			end,
		}),
	},
})
