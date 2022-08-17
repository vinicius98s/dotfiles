-- Tmux colorscheme
vim.cmd [[
  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
]]

-- Ayu
-- local colorscheme = "ayu"
-- vim.g.ayucolor = "dark"

-- Material
-- vim.g.material_style = "deep ocean"
-- local colorscheme = "material"

-- Oxocarbon
local colorscheme = "oxocarbon-lua"

-- Tokyonight
-- local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "night"

-- Nord
-- local colorscheme = "nord"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

