-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
local default_image_path = "./default_background_image.*"

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local is_colorsheme_imported, my_colorscheme = pcall(require, "lua.colorscheme_my")
if is_colorsheme_imported then
  config.color_scheme = my_colorscheme.colorscheme
else
  -- config.color_scheme = "AdventureTime"
  -- config.color_scheme = "Tokyo Night Moon"
  -- config.color_scheme = "ToyChest"
  config.color_scheme = "s3r0 modified (terminal.sexy)"
end

config.font = wezterm.font("JetBrainsMono-Regular")
config.window_background_opacity = 0.8
config.font_size = 14.0

local maybe_background_image = wezterm.glob(default_image_path, wezterm.config_dir)[1]
if maybe_background_image then
  config.window_background_image = wezterm.config_dir .. "/" .. maybe_background_image
  config.window_background_image_hsb = {
    brightness = 0.03,
    hue = 1.0,
    saturation = 1.0,
  }
else
  config.window_background_gradient = {
    orientation = "Vertical",
    colors = {
      "#0f0c29",
      "#302b63",
      "#24243e",
    },
    interpolation = "Linear",
    blend = "Rgb",
  }
end

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
