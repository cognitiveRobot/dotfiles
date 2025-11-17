local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	font_size = 14.0,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "NONE", -- disable title bar
	default_cursor_style = "BlinkingBar",

	-- https://wezterm.org/config/appearance.html#defining-your-own-colors
	colors = {
		background = "#282c35",
		cursor_bg = "#ffffff",
		cursor_border = "#ffffff",
	},
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "|",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{
			key = "-",
			mods = "SHIFT|CTRL",
			action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
		},
		-- {
		-- 	key = '\'',
		-- 	mods = 'CTRL',
		-- 	action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
		-- },
	},

	-- background = {
	-- 	{
	-- 		source = {
	-- 			Color = "#282c35",
	-- 		},
	-- 		width = "100%",
	-- 		height = "100%",
	-- 		-- opacity = 0.55,
	-- 	},
	-- },
	-- window_padding = {
	-- 	left = 3,
	-- 	right = 3,
	-- 	top = 3,
	-- 	bottom = 3,
	-- },
}

return config
