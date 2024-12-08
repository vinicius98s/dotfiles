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

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

require("user.keymaps")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "tpope/vim-sleuth" },
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
				telescope.setup({
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
			"folke/tokyonight.nvim",
			priority = 1000,
			init = function()
				vim.cmd.colorscheme("tokyonight-night")
				vim.cmd.hi("Comment gui=none")
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
			config = function()
				local lualine = require("lualine")
				lualine.setup({})
			end,
		},

		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"j-hui/fidget.nvim",
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
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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
					rust_analyzer = {
						settings = {
							["rust-analyzer"] = {
								checkOnSave = {
									command = "clippy",
								},
							},
						},
					},
					lua_ls = {},
					ts_ls = {},
				}

				require("mason").setup()

				require("mason-tool-installer").setup({
					ensure_installed = {
						"stylua",
						"prettierd",
						"eslint-lsp",
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
					javascript = { "prettierd", "prettier", stop_after_first = true },
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
	},

	-- Configure any other settings here. See the documentation for more details.
	install = {},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
