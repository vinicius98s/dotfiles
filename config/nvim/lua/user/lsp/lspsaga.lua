local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.init_lsp_saga({
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  border_style = "rounded",
  symbol_in_winbar = {
    in_custom = true
  }
})

