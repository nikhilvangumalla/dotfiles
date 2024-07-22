local wez = require("wezterm")

local NV = {}

local config = require("bar.config")
local utils = require("bar.utils")
local tabs = require("bar.tabs")
local user = require("bar.user")
local paths = require("bar.paths")
local options = config.options

NV.apply_to_config = function(c)
	-- make the plugin own these settings
	c.tab_bar_at_bottom = options.position == "bottom"
	c.use_fancy_tab_bar = options.use_fancy_tab_bar
	c.tab_max_width = options.max_width
	c.enable_tab_bar = options.enable_tab_bar

	wez.on("format-tab-title", function(tab, _, _, conf, _, _)
		local palette = conf.resolved_palette

		local index = tab.tab_index + 1
		local offset = #tostring(index) + #options.separator.left_icon + (2 * options.separator.space) + 2
		local title = index
			.. utils._space(options.separator.left_icon, options.separator.space, nil)
			.. tabs.get_title(tab)

		local width = conf.tab_max_width - offset
		if #title > conf.tab_max_width then
			title = wez.truncate_right(title, width) .. "…"
		end

		local fg = palette.tab_bar.inactive_tab.fg_color
		local bg = palette.tab_bar.inactive_tab.bg_color
		if tab.is_active then
			fg = palette.tab_bar.active_tab.fg_color
			bg = palette.tab_bar.active_tab.bg_color
		end

		return {
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Text = utils._space(title, 0, 2) },
		}
	end)

	wez.on("update-status", function(window, pane)
		local present, conf = pcall(window.effective_config, window)
		if not present then
			return
		end

		local palette = conf.resolved_palette

		-- left status
		local left_cells = {
			{ Background = { Color = palette.tab_bar.background } },
		}

		table.insert(left_cells, { Text = string.rep(" ", options.padding.left) })

		if options.modules.workspace.enabled then
			local stat = options.modules.workspace.icon
				.. utils._space(window:active_workspace(), options.separator.space)
			local stat_fg = palette.ansi[options.modules.workspace.color]

			if window:active_key_table() then
				stat_fg = palette.ansi[options.modules.leader.color]
				if window:active_key_table() == "move_tab" then
					stat = utils._constant_width(stat, options.key_table.move_tabs.icon)
				end
				if window:active_key_table() == "resize_pane" then
					stat = utils._constant_width(stat, options.key_table.resize_panes.icon)
				end
			end

			if options.modules.leader.enabled and window:leader_is_active() then
				stat_fg = palette.ansi[options.modules.leader.color]
				stat = utils._constant_width(stat, options.modules.leader.icon)
			end

			table.insert(left_cells, { Foreground = { Color = stat_fg } })
			table.insert(left_cells, { Text = stat })
		end

		if options.modules.pane.enabled then
			local process = pane:get_foreground_process_name()
			if not process then
				goto set_left_status
			end
			table.insert(left_cells, { Foreground = { Color = palette.ansi[options.modules.pane.color] } })
			table.insert(left_cells, {
				Text = options.modules.pane.icon .. utils._space(utils._basename(process), options.separator.space),
			})
		end

		::set_left_status::
		window:set_left_status(wez.format(left_cells))

		-- right status
		local right_cells = {
			{ Background = { Color = palette.tab_bar.background } },
		}

		local callbacks = {
			{
				name = "username",
				func = function()
					return user.username
				end,
			},
			{
				name = "hostname",
				func = function()
					return wez.hostname()
				end,
			},
			{
				name = "clock",
				func = function()
					return wez.time.now():format("%H:%M")
				end,
			},
			{
				name = "cwd",
				func = function()
					return paths.get_cwd(pane, true)
				end,
			},
		}

		for _, callback in ipairs(callbacks) do
			local name = callback.name
			local func = callback.func
			if not options.modules[name].enabled then
				goto continue
			end
			local text = func()
			if #text > 0 then
				table.insert(right_cells, { Foreground = { Color = palette.ansi[options.modules[name].color] } })
				table.insert(right_cells, { Text = text })
				table.insert(right_cells, { Foreground = { Color = palette.brights[1] } })
				table.insert(right_cells, {
					Text = utils._space(options.separator.right_icon, options.separator.space, nil)
						.. options.modules[name].icon,
				})
				table.insert(
					right_cells,
					{ Text = utils._space(options.separator.field_icon, options.separator.space, nil) }
				)
			end
			::continue::
		end
		-- remove trailing separator
		table.remove(right_cells, #right_cells)
		table.insert(right_cells, { Text = string.rep(" ", options.padding.right) })

		window:set_right_status(wez.format(right_cells))
	end)
end

return NV
