-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { italic = true }),
	},
	{
		italic = true,
		intensity = "Bold",
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { italic = true, weight = "Bold" }),
	},
}

config.font_size = 19

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- my coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#000000",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#fab387",
	selection_fg = "#000000",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.window_background_opacity = 0.5
config.macos_window_background_blur = 15

config.set_environment_variables = {
	WEZTERM_PANE = os.getenv("WEZTERM_PANE"),
}
-- and finally, return the configuration to wezterm

return config
