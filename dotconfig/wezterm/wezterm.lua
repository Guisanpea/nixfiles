local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback({
    'JetBrains Mono Nerd Font',
    'Noto Sans Mono',
  }),
  font_size = 14.0,

  -- Catppuccin Theme
  color_scheme = 'Catppuccin Latte',

  -- Window configuration
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
  },

  -- Tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  -- General settings
  automatically_reload_config = true,
  window_background_opacity = 0.95,
}
