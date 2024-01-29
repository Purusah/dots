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
config.window_background_opacity = 0.75
config.window_background_gradient = {
  orientation = "Vertical",

  -- Specifies the set of colors that are interpolated in the gradient.
  -- Accepts CSS style color specs, from named colors, through rgb
  -- strings and more
  colors = {
    "#0f0c29",
    "#302b63",
    "#24243e",
  },

  -- Instead of specifying `colors`, you can use one of a number of
  -- predefined, preset gradients.
  -- A list of presets is shown in a section below.
  -- preset = "Warm",

  -- Specifies the interpolation style to be used.
  -- "Linear", "Basis" and "CatmullRom" as supported.
  -- The default is "Linear".
  interpolation = "Linear",

  -- How the colors are blended in the gradient.
  -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
  -- The default is "Rgb".
  blend = "Rgb",

  -- To avoid vertical color banding for horizontal gradients, the
  -- gradient position is randomly shifted by up to the `noise` value
  -- for each pixel.
  -- Smaller values, or 0, will make bands more prominent.
  -- The default value is 64 which gives decent looking results
  -- on a retina macbook pro display.
  -- noise = 64,

  -- By default, the gradient smoothly transitions between the colors.
  -- You can adjust the sharpness by specifying the segment_size and
  -- segment_smoothness parameters.
  -- segment_size configures how many segments are present.
  -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
  -- 1.0 is a soft edge.

  -- segment_size = 11,
  -- segment_smoothness = 0.0,
}

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
