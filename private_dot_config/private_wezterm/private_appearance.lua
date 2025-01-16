local wezterm = require "wezterm"

local config = {}

config.bold_brightens_ansi_colors = "BrightAndBold"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 500
config.cursor_thickness = "1"
config.default_cursor_style = "BlinkingBlock"
config.font = wezterm.font_with_fallback { "MonoLisa", "MonaSpace" }
config.font_size = 15
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

-- On macOS, "RESIZE|INTEGRATED_BUTTONS". disable to display a full title bar
-- config.window_decorations = "RESIZE"

config.macos_window_background_blur = 25
config.window_background_opacity = 0.85

config.window_frame = {
  font = wezterm.font({ family = "MonoLisa", weight = "Bold" }),
  font_size = 15,
}

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

return config
