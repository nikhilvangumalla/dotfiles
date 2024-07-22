local wez = require("wezterm")
local act = wez.action
local callback = wez.action_callback

local mod = {
	c = "CTRL",
	s = "SHIFT",
	a = "ALT",
	l = "LEADER",
}

local keybind = function(mods, key, action)
	return { mods = table.concat(mods, "|"), key = key, action = action }
end

local NV = {}

local leader = { mods = mod.c, key = "a", timeout_miliseconds = 1000 }
local key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

local keys = function()
	local keys = {
		-- Basic
		keybind({ mod.l, mod.c }, "a", act.SendString("\x01")),
		keybind({ mod.l }, "c", act.ActivateCopyMode),
		keybind({ mod.l }, "phys:Space", act.ActivateCommandPalette),

		-- Pane
		keybind({ mod.l }, "s", act.SplitVertical({ domain = "CurrentPaneDomain" })),
		keybind({ mod.l }, "v", act.SplitHorizontal({ domain = "CurrentPaneDomain" })),
		keybind({ mod.l }, "h", act.ActivatePaneDirection("Left")),
		keybind({ mod.l }, "j", act.ActivatePaneDirection("Down")),
		keybind({ mod.l }, "k", act.ActivatePaneDirection("Up")),
		keybind({ mod.l }, "l", act.ActivatePaneDirection("Right")),
		keybind({ mod.l }, "q", act.CloseCurrentPane({ confirm = true })),
		keybind({ mod.l }, "z", act.TogglePaneZoomState),
		keybind({ mod.l }, "o", act.RotatePanes("Clockwise")),

		-- Tab
		keybind({ mod.l }, "t", act.SpawnTab("CurrentPaneDomain")),
		keybind({ mod.l }, "[", act.ActivateTabRelative(-1)),
		keybind({ mod.l }, "]", act.ActivateTabRelative(1)),
		keybind({ mod.l }, "n", act.ShowTabNavigator),
		keybind(
			{ mod.l },
			"e",
			act.PromptInputLine({
				description = wez.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Renaming Tab Title...:" },
				}),
				action = callback(function(win, _, line)
					if line == "" then
						return
					end
					win:active_tab():set_title(line)
				end),
			})
		),
		keybind({ mod.l }, "r", act.ActivateKeyTable({ name = "resize_pane", one_shot = false })),
		keybind({ mod.l }, "m", act.ActivateKeyTable({ name = "move_tab", one_shot = false })),
		keybind({ mod.l, mod.s }, "{", act.MoveTabRelative(-1)),
		keybind({ mod.l, mod.s }, "}", act.MoveTabRelative(1)),
		keybind({ mod.l }, "w", act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })),

		-- update all plugins
		keybind(
			{ mod.l },
			"u",
			callback(function(win)
				wez.plugin.update_all()
				win:toast_notification("wezterm", "plugins updated!", nil, 4000)
			end)
		),
	}
	for i = 1, 9 do
		table.insert(keys, keybind({ mod.l }, tostring(i), act.ActivateTab(i - 1)))
	end
	return keys
end

NV.apply_to_config = function(config)
	config.leader = leader
	config.keys = keys()
	config.key_tables = key_tables
end
return NV
