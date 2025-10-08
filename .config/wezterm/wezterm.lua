local wezterm = require 'wezterm'
local config = {}

config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled'
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.window_background_opacity = 0.8
config.font = wezterm.font 'ComicShannsMonoNerdFontMono'
config.font_size = 12.0
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.keys = {
    {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.DisableDefaultAssignment,
    },
}

return config
