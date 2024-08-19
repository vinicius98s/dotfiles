local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
	return
end

formatter.setup({
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    typescript = {
      require("formatter.filetypes.typescript").prettierd
    }
  }
})

vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
