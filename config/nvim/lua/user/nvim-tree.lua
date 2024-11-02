-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("nvim-tree not installed")
	return
end

-- Remove status line on NvimTree
vim.cmd([[au BufEnter * if bufname('%') == "NvimTree_1" | set laststatus=0 | endif]])
vim.cmd([[au BufLeave * if bufname('%') == "NvimTree_1" | set laststatus=3 | endif]])

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "★",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	filters = {
		dotfiles = false,
		custom = {
			"node_modules",
			".cache",
			"^.git$",
		},
	},
	view = {
		width = 30,
		-- hide_root_folder = false,
		side = "right",
		number = false,
		relativenumber = false,
	},
})
