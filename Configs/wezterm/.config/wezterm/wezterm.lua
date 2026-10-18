local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- WSL2 default
config.default_domain = "WSL:Ubuntu"

-- Kanagawa Dragon (same palette as nvim + opencode kanagawa-transparent)
config.colors = {
	foreground = "#C5C9C5",
	background = "#181616",
	cursor_bg = "#C5C9C5",
	cursor_fg = "#181616",
	cursor_border = "#C5C9C5",
	selection_fg = "#C5C9C5",
	selection_bg = "#2D4F67",
	scrollbar_thumb = "#393836",
	split = "#393836",
	ansi = { "#0D0C0C", "#C4746E", "#8A9A7B", "#C4B28A", "#8BA4B0", "#A292A3", "#8EA4A2", "#C8C093" },
	brights = { "#A6A69C", "#E46876", "#87A987", "#E6C384", "#7FB4CA", "#938AA9", "#7AA89F", "#C5C9C5" },
	tab_bar = {
		background = "#181616",
		active_tab = { bg_color = "#2D4F67", fg_color = "#E6E4DC" },
		inactive_tab = { bg_color = "#26252B", fg_color = "#9E9B93" },
		inactive_tab_hover = { bg_color = "#393836", fg_color = "#C5C9C5" },
		new_tab = { bg_color = "#181616", fg_color = "#9E9B93" },
		new_tab_hover = { bg_color = "#393836", fg_color = "#C5C9C5" },
	},
}
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 16.0

-- Opacity: near-solid window; coloured cells (panels, floats, statusline)
-- are a bit more see-through than the base so they read as tinted glass.
config.window_background_opacity = 0.96
config.text_background_opacity = 0.75
config.win32_system_backdrop = "Disable"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Clipboard & passthrough
config.enable_kitty_graphics = true

-- Opacity levels cycled by Ctrl+Alt+O (first press -> first entry, ...,
-- last entry -> back to the configured default above)
local OPACITY_CYCLE = { 0.85, 1.0 }

-- Keys
config.keys = {
	-- F11: toggle fullscreen
	{ key = "F11", mods = "NONE", action = wezterm.action.ToggleFullScreen },
	-- Ctrl+Alt+V: smart paste (image → file path, text → normal paste)
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			local home = os.getenv("HOME") or "/home/jjspscl"
			local success, stdout, stderr = wezterm.run_child_process({
				home .. "/.local/bin/clip2path",
			})
			if success and stdout then
				local text = stdout:gsub("[\r\n]+$", "")
				pane:send_text(text)
			end
		end),
	},
	-- Ctrl+Alt+O: cycle window opacity
	{
		key = "o",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window)
			local overrides = window:get_config_overrides() or {}
			local current = overrides.window_background_opacity
			local next_value = OPACITY_CYCLE[1]
			for i, value in ipairs(OPACITY_CYCLE) do
				if current == value then
					next_value = OPACITY_CYCLE[i + 1] -- nil after last => default
					break
				end
			end
			overrides.window_background_opacity = next_value
			window:set_config_overrides(overrides)
		end),
	},
}

return config
