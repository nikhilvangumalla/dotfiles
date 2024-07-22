local wez = require("wezterm")

local NV = {}

NV.apply_to_config = function(config)
	config.font = wez.font("FiraCode Nerd Font")
	-- config.window_background_opacity = 0.9
	config.window_decorations = "RESIZE"
	config.color_scheme = "Tokyo Night Moon"
	config.window_close_confirmation = "AlwaysPrompt"
	config.scrollback_lines = 3000
	config.default_workspace = "main"
	config.window_padding = {
		left = "0",
		right = "0",
		top = "0",
		bottom = "0",
	}
	config.show_new_tab_button_in_tab_bar = false

	-- Dim inactive panes
	config.inactive_pane_hsb = {
		saturation = 0.25,
		brightness = 0.5,
	}
end

return NV
