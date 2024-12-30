local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  color_scheme = "Catppuccin Latte",
  font_size = 14.0,
  font = wezterm.font 'MesloLGS NF',
}

return config
