-- Tmux colorscheme
vim.cmd([[
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
]])

-- Ayu
-- vim.g.ayucolor = "dark"
local colorscheme = "ayu-dark"
require("ayu").setup({})

-- Material
-- vim.g.material_style = "deep ocean"
-- local colorscheme = "material"

-- nightfox
-- local colorscheme = "nightfox"

-- Oxocarbon
-- local colorscheme = "oxocarbon"

-- Rose Pine
-- local colorscheme = "rose-pine"

-- Bluloco
-- local colorscheme = "bluloco-dark"

-- Tokyonight
-- local colorscheme = "tokyonight-night" -- "tokyonight" | "tokyonight-night" | "tokyonight-day" | "tokyonight-storm" | "tokyonight-moon"

-- Nord
-- local colorscheme = "nord"

-- Srcery
-- local colorscheme = "srcery"

-- Neofusion
-- vim.o.background = "dark"
-- local colorscheme = "neofusion"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
