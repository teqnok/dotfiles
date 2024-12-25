local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.max_fps = 165
config.default_cursor_style = 'SteadyBar'
config.color_scheme = 'catppuccin-mocha'
config.enable_tab_bar = false

return config
