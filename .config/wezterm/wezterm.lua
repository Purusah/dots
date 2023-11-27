-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Tokyo Night Moon'
config.color_scheme = "s3r0 modified (terminal.sexy)"
config.font = wezterm.font("JetBrainsMono-Regular")

config.disable_default_key_bindings = true
config.keys = {
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "Enter",
		mods = "ALT", -- Option in MacOS
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "-",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "0",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowDebugOverlay,
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CharSelect,
	},
	{
		key = "f",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Search({ CaseSensitiveString = "" }),
	},
	-- Ctrl-Left to jump left
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Ctrl-Right to jump right
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bf" }) },
}
-- and finally, return the configuration to wezterm
return config
