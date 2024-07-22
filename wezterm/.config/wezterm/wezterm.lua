local wez = require("wezterm")
local act = wez.action

local appearance = require("appearance")
local mappings = require("mappings")
local bar = require("bar")

local config = {}

if wez.config_builder then
	config = wez.config_builder()
end

local mux = wez.mux

wez.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wez.action.ToggleFullScreen, pane)
end)

config.color_scheme = "Tokyo Night Moon"

bar.apply_to_config(config)

appearance.apply_to_config(config)

mappings.apply_to_config(config)

-- local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
-- modal.apply_to_config(config)

return config
