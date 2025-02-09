{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
            				 local wezterm = require("wezterm")

            				 local config = wezterm.config_builder()

            				 config.font = wezterm.font("Berkeley Mono")
            				 config.font_size = 13.0

      							 config.front_end = "WebGpu"

            				 config.enable_tab_bar = true
            				 config.hide_tab_bar_if_only_one_tab = true

            				 config.window_decorations = "RESIZE"

            				 config.audible_bell = "Disabled"

            				 config.color_scheme = 'carbonfox'
            				 config.background = {
            					 {
            						 source = {
            							 File = "/home/abhi/Pictures/Wallpapers/peakpx.jpg"
            						 },
            						 height = "Cover",
            						 hsb = {
            							 brightness = 0.03,
            						 }
            					 }
            				 }

            			 config.default_cursor_style = 'SteadyBlock'
            				 return config
            				 '';
  };
}
