local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable title bar
	default_cursor_style = "BlinkingBar",

	-- https://wezterm.org/config/appearance.html#defining-your-own-colors
	colors = {
		background = "#282c35",
		cursor_bg = "#ffffff",
		cursor_border = "#ffffff",
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
