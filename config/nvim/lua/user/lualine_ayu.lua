-- lualine theme matching colors/ayu-dark.lua
local c = {
	bg = "#0b0e14",
	bg_dim = "#0d1017",
	bg_panel = "#0f131a",
	fg = "#bfbdb6",
	fg_idle = "#565b66",
	accent = "#e6b450",
	keyword = "#ff8f40",
	string = "#aad94c",
	entity = "#59c2ff",
	constant = "#d2a6ff",
	error = "#d95757",
}

local function mode(color)
	return {
		a = { fg = c.bg, bg = color, gui = "bold" },
		b = { fg = color, bg = c.bg_panel },
		c = { fg = c.fg_idle, bg = c.bg_dim },
	}
end

return {
	normal = mode(c.accent),
	insert = mode(c.string),
	visual = mode(c.constant),
	replace = mode(c.keyword),
	command = mode(c.entity),
	terminal = mode(c.entity),
	inactive = {
		a = { fg = c.fg_idle, bg = c.bg_dim, gui = "bold" },
		b = { fg = c.fg_idle, bg = c.bg_dim },
		c = { fg = c.fg_idle, bg = c.bg_dim },
	},
}
