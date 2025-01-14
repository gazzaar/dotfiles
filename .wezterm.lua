-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()
-- This is where you actually apply your config choices
config.force_reverse_video_cursor = true
config.color_scheme = "Gruvbox Dark (Gogh)"
config.colors = {
	foreground = "#d5c4a1",
}
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.max_fps = 120
-- -- Fonts
config.font_size = 20
config.font = wezterm.font({ family = "FiraCode Nerd Font" })
config.bold_brightens_ansi_colors = true
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Maple Mono", weight = "Bold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({ family = "Maple Mono", weight = "DemiBold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({ family = "Maple Mono", style = "Italic" }),
	},
}
config.default_cursor_style = "SteadyBar"
config.enable_tab_bar = false
config.window_padding = {
	left = 3,
	right = 0,
	top = 3,
	bottom = 0,
}
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 8
-- and finally, return the configuration to wezterm
return config
