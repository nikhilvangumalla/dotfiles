local wez = require("wezterm")

local NV = {}

NV.apply_to_config = function(config)
	config.font = wez.font_with_fallback({ "FiraCode Nerd Font" })
	-- config.font = wez.font_with_fallback({ "FiraCode Nerd Font", "Terminess Nerd Font" })
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

	-- Dim inactive panes
	config.inactive_pane_hsb = {
		saturation = 0.25,
		brightness = 0.5,
	}

	config.enable_tab_bar = false
	config.enable_wayland = true
end

return NV
