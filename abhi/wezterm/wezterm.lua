local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("Berkeley Mono")
config.font_size = 13.0

config.enable_tab_bar = false
config.window_decorations = "NONE"

config.audible_bell = "Disabled"

-- config.color_scheme = 'Afterglow (Gogh)'
config.color_scheme = 'carbonfox'

config.background = {
	{
		source = {
			File = "./Pictures/Wallpapers/peakpx.jpg"
		},
		height = "Cover",
		hsb = {
			brightness = 0.03,
		}
	}
}

config.default_cursor_style = 'SteadyBlock'

return config
