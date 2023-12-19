local animate_ok, animate = pcall(require, "mini.animate")
if not animate_ok then
	return
end

animate.setup({
	-- Cursor path
	cursor = {
		enable = true,
		timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
	},

	-- Vertical scroll
	scroll = {
		enable = true,
	},

	-- Window resize
	resize = {
		enable = true,
	},

	-- Window open
	open = {
		enable = true,
	},

	-- Window close
	close = {
		enable = true,
	},
})
