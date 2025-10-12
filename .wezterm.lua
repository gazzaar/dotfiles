local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Function to choose scheme based on system appearance
local function choose_scheme()
	local appearance = wezterm.gui.get_appearance()
	if appearance:find("Dark") then
		return "Gruvbox Dark (Gogh)"
	else
		return "Gruvbox Light"
	end
end

config.force_reverse_video_cursor = true
config.color_scheme = choose_scheme()

config.colors = {
	-- foreground = "#d5c4a1",
}

config.max_fps = 120
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
config.window_background_opacity = 0.8
config.macos_window_background_blur = 9

return config
