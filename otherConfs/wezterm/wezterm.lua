local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font_size = 15.0
config.line_height = 1.2
config.font = wezterm.font("JetBrains Mono")

config.window_decorations = "RESIZE"
config.initial_rows = 40
config.initial_cols = 150

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 22
config.enable_tab_bar = false

config.colors = require("nordic")

config.send_composed_key_when_left_alt_is_pressed = true

return config
