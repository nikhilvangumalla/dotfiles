local wez = require("wezterm")

local NV = {}

NV.options = {
	position = "bottom",
	max_width = 32,
	use_fancy_tab_bar = false,
	enable_tab_bar = true,
	padding = {
		left = 1,
		right = 1,
	},
	separator = {
		space = 1,
		left_icon = wez.nerdfonts.fa_long_arrow_right,
		right_icon = wez.nerdfonts.fa_long_arrow_left,
		field_icon = wez.nerdfonts.indent_line,
	},
	key_table = {
		move_tabs = {
			enabled = true,
			icon = wez.nerdfonts.cod_arrow_swap,
			color = 2,
		},
		resize_panes = {
			enabled = true,
			icon = wez.nerdfonts.cod_link_external,
			color = 2,
		},
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
		},
		workspace = {
			enabled = true,
			icon = wez.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wez.nerdfonts.oct_rocket,
			color = 2,
		},
		pane = {
			enabled = false,
			icon = wez.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = false,
			icon = wez.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = false,
			icon = wez.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = true,
			icon = wez.nerdfonts.md_calendar_clock,
			color = 5,
		},
		cwd = {
			enabled = true,
			icon = wez.nerdfonts.oct_file_directory,
			color = 7,
		},
	},
}

return NV