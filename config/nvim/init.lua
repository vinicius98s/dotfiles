-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	title = true,
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 0, -- always show tabs
	smartcase = true, -- smart case
	smarttab = true,
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = false, -- set relative numbered lines
	numberwidth = 1, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	guifont = "monospace:h20", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

require("user.keymaps")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local oil = require("oil")
				oil.setup({
					float = {
						padding = 4,
						max_width = 80,
					},
					keymaps = {
						["q"] = { "actions.close", mode = "n" },
					},
				})

				vim.keymap.set("n", "<leader>f", oil.toggle_float, { desc = "[F]iles" })
			end,
		},

		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "▎" },
					topdelete = { text = "▎" },
					changedelete = { text = "▎" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 250,
					virt_text_pos = "right_align",
				},
				on_attach = function()
					local gitsigns = require("gitsigns")

					vim.keymap.set("n", "<leader>p", gitsigns.preview_hunk, { desc = "[p]review git hunk" })
					vim.keymap.set("n", "<leader>pr", gitsigns.reset_hunk, { desc = "[r]eset git hunk" })
					vim.keymap.set("n", "]c", function()
						gitsigns.nav_hunk("next")
					end, { desc = "Jump to next git [c]hange" })
					vim.keymap.set("n", "[c", function()
						gitsigns.nav_hunk("prev")
					end, { desc = "Jump to previous git [c]hange" })
					vim.keymap.set({ "n", "v" }, "<leader>ps", gitsigns.stage_hunk, { desc = "stage git hunk" })
				end,
			},
		},

		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
		},

		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			opts = {
				notifier = { enabled = true },
				dashboard = {
					preset = {
						header = [[
⠀⠀⠀⢸⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡾⠀⠀⠀
⢰⡶⠶⠎⢿⣿⣷⣔⠶⠶⠶⠶⠶⠶⢶⡶⠶⠶⠶⠶⠶⠶⢖⣴⣿⣿⠣⠶⢶⡆
⢸⡴⣶⣄⡈⠻⣿⣿⣦⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣴⣿⣿⡿⠁⣠⣴⣆⡇
⢸⡇⠹⣿⣿⣦⡈⠻⣿⢸⣦⡀⠀⠀⢸⡇⠀⠀⠀⣠⡆⢻⠟⢋⣴⣾⣿⡟⢸⡇
⢸⢣⣀⡙⠿⣿⣿⣧⢈⠸⣿⣿⣦⡀⢸⡇⠀⣠⣾⣿⠇⢁⢰⣿⣿⡿⠋⣀⣸⡇
⢸⡏⢿⣿⣷⣌⡛⢿⢸⣷⣌⠙⢿⣿⠎⡃⣾⣿⠟⣡⣾⡟⡸⠟⣡⣴⣿⡿⢳⡇
⢸⢡⣀⠙⠿⣿⣿⢠⣀⠻⣿⣷⠀⣡⣾⡇⠟⢁⣾⣿⠟⢁⡄⣼⣿⡿⠛⣁⡌⡇
⢸⡏⢿⣿⣶⣬⡙⠇⢿⣷⣌⢁⣾⣿⠟⢁⠀⣿⠟⣡⣶⡿⠡⢛⣡⣴⣿⡿⢳⡇
⢸⡷⢦⡝⢿⣿⣧⢰⣤⡙⢿⢸⡿⠁⣴⣿⠈⣡⣾⡿⠟⣡⡶⣸⣿⣿⠟⠵⢾⡇
⢸⡞⢷⣶⣤⣉⠻⠆⢿⣿⡦⠈⣠⣾⠟⣡⢀⠿⢋⣴⣿⣿⠣⠟⣋⣠⣴⣶⢦⡇
⢸⡇⠈⠻⣿⣿⣿⠠⣤⡙⠃⢸⡿⣡⣾⠟⣠⢰⣿⠿⠋⣡⡄⣾⣿⣿⠟⠁⢸⡇
⢸⡇⠰⣶⣦⣍⡛⠃⢻⣿⡇⢈⣴⡿⢁⣼⠏⢊⣡⣶⣿⡿⠱⢛⣩⣤⣶⡖⢸⡇
⢸⡇⠀⠈⠻⣿⣿⡇⣦⣈⠁⠸⢋⣴⠟⢁⡴⣸⠿⠛⣉⣤⢢⣿⣿⡿⠋⠀⢸⡇
⢸⡇⠀⠰⣶⣦⣝⡛⠘⢿⡇⢠⠟⣡⣾⠟⠁⢀⣴⣾⣿⠏⢚⣫⣥⣶⠖⠀⢸⡇
⢸⡇⠀⠀⠈⠛⠿⣿⡄⣶⡄⣠⠞⠋⣠⡴⠣⠟⣋⣩⣴⢂⣿⠿⠟⠉⠀⠀⢸⡇
⢸⡇⠀⠀⠀⠱⣶⣤⣤⣈⠀⣠⡶⠟⣋⡅⣰⡿⠿⠛⡃⣠⣤⣶⠞⠀⠀⠀⢸⡇
⠈⠛⠷⣦⣄⡀⠀⠉⠛⠋⢈⣥⣶⠿⠋⢈⣥⣶⣾⠟⠐⠛⠋⠁⠀⣠⣴⠾⠛⠁
⠀⠀⠀⠀⠉⠛⠮⣟⣻⠀⢋⣡⣴⡾⢁⣛⣯⣵⢖⣴⣿⡿⢟⠵⠛⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣩⠾⢛⣯⣁⠀⢰⡆⠀⣀⣤⡐⠶⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠈⠙⠻⢾⡷⠟⠋⠁⠀⠀⠀⠑⠀⠀⠀⠀⠀⠀⠀
]],
					},
					sections = {
						{ section = "header" },
						{
							pane = 2,
							section = "terminal",
							cmd = "colorscript -e square",
							height = 5,
							padding = 1,
						},
						{
							pane = 2,
							icon = " ",
							title = "Recent Files",
							section = "recent_files",
							indent = 2,
							padding = 1,
						},
						{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
						{ section = "startup" },
					},
				},
			},
		},

		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			event = "VimEnter",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-telescope/telescope-ui-select.nvim",
			},
			config = function()
				local telescope = require("telescope")
				local actions = require("telescope.actions")
				telescope.setup({
					defaults = {
						prompt_prefix = "   ",
						selection_caret = "  ",
						entry_prefix = "  ",
						mappings = {
							i = {
								["<C-j>"] = actions.move_selection_next,
								["<C-k>"] = actions.move_selection_previous,
							},
							n = {
								["q"] = actions.close,
								["<C-j>"] = actions.move_selection_next,
								["<C-k>"] = actions.move_selection_previous,
							},
						},
					},
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				telescope.load_extension("fzf")
				telescope.load_extension("ui-select")

				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				-- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
			end,
		},

		{
			"j-morano/buffer_manager.nvim",
			config = function()
				local ui = require("buffer_manager.ui")
				vim.keymap.set("n", "<leader><leader>", ui.toggle_quick_menu, { desc = "[ ] Find existing buffers" })
			end,
		},

		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},

		{ "Bilal2453/luvit-meta", lazy = true },

		{
			"nyoom-engineering/oxocarbon.nvim",
			lazy = false,
			priority = 1000,
			init = function()
				vim.cmd.colorscheme("oxocarbon")
			end,
		},

		{
			"echasnovski/mini.nvim",
			config = function()
				local animate = require("mini.animate")
				animate.setup({
					cursor = {
						timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
					},
				})

				local pairs = require("mini.pairs")
				pairs.setup({})
			end,
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},

		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "williamboman/mason.nvim", config = true },
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				{ "j-hui/fidget.nvim", opts = {} },
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
						map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
						map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
						-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
						map("<leader>d", vim.diagnostic.open_float, "Open [d]iagnostics")

						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
								end,
							})
						end

						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})

				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({ signs = { text = diagnostic_signs } })

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				local servers = {
					lua_ls = {},
					ts_ls = {},
				}

				require("mason").setup()

				require("mason-tool-installer").setup({
					ensure_installed = {
						"stylua",
						"prettier",
						"eslint-lsp",
						"tailwindcss-language-server",
						"jsonlint",
						"hadolint",
					},
				})

				require("mason-lspconfig").setup({
					ensure_installed = vim.tbl_keys(servers or {}),
					automatic_installation = true,
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},

		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			opts = {
				notify_on_error = false,
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					javascript = { "prettier" },
				},
			},
		},

		{
			"saecki/crates.nvim",
			tag = "stable",
			config = function()
				require("crates").setup({})
			end,
		},

		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					build = "make install_jsregexp",
				},
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				vim.api.nvim_create_autocmd({ "InsertLeave" }, {
					callback = function()
						if luasnip.expand_or_jumpable() then
							luasnip.unlink_current()
						end
					end,
				})

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					completion = { completeopt = "menu,menuone,noinsert" },
					mapping = cmp.mapping.preset.insert({
						["<C-j>"] = cmp.mapping.select_next_item(),
						["<C-k>"] = cmp.mapping.select_prev_item(),

						["<CR>"] = cmp.mapping.confirm({ select = true }),

						["<C-Space>"] = cmp.mapping.complete({}),
					}),
					sources = {
						{
							name = "lazydev",
							group_index = 0,
						},
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "path" },
					},
				})
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			main = "nvim-treesitter.configs",
			opts = {
				ensure_installed = { "lua", "rust", "javascript", "typescript", "tsx", "markdown", "markdown_inline" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			},
		},

		{
			"numToStr/Comment.nvim",
			dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
			config = function()
				local pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
				---@diagnostic disable-next-line: missing-fields
				require("Comment").setup({
					---@diagnostic disable-next-line: missing-fields
					toggler = {
						line = "<leader>/",
					},
					---@diagnostic disable-next-line: missing-fields
					opleader = {
						line = "<leader>/",
					},
					pre_hook = pre_hook,
				})
			end,
		},

		{
			"windwp/nvim-ts-autotag",
			opts = {},
		},

		{
			"mfussenegger/nvim-lint",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				local lint = require("lint")

				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					callback = function()
						if vim.opt_local.modifiable:get() then
							lint.try_lint()
						end
					end,
				})
			end,
		},

		{
			"rachartier/tiny-inline-diagnostic.nvim",
			event = "VeryLazy", -- Or `LspAttach`
			priority = 1000, -- needs to be loaded in first
			config = function()
				vim.diagnostic.config({ virtual_text = false })
				require("tiny-inline-diagnostic").setup({
					preset = "powerline",
				})
			end,
		},

		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		},

		{
			"mrcjkb/rustaceanvim",
			version = "^5", -- Recommended
			lazy = false, -- This plugin is already lazy
		},
	},

	-- Configure any other settings here. See the documentation for more details.
	install = {},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
