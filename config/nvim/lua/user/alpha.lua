local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local fortune = require("alpha.fortune")
local dashboard = require("alpha.themes.dashboard")

local function button(sc, txt, keybind, keybind_opts)
	local b = dashboard.button(sc, txt, keybind, keybind_opts)
	b.opts.hl_shortcut = "Macro"
	return b
end

dashboard.section.buttons.val = {
	button("f", "  Find file", ":Telescope find_files <CR>"),
	button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	button("t", "  Find text", ":Telescope live_grep <CR>"),
	button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
	button("u", "  Update", ":PackerSync<CR>"),
	button("q", "  Quit", ":qa<CR>"),
}

-- Everyone could use a good fortune cookie from time to time, right?
dashboard.section.footer.val = fortune()

alpha.setup({
	layout = {
		{ type = "padding", val = 5 },
		dashboard.section.header,
		{ type = "padding", val = 2 },
		dashboard.section.buttons,
		dashboard.section.footer,
	},
})
