local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Solarized Dark (Gogh)'
-- config.color_scheme = 'Monokai Pro (Gogh)'
-- config.font = wezterm.font 'Space Mono for Powerline'
config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'FiraCode Nerd Font'

config.window_decorations = "RESIZE"

-- Appearance
config.window_background_opacity = 0.9
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
