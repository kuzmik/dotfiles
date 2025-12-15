local wezterm = require 'wezterm'
local config = {}

-- Enable OSC 52 clipboard integration (allows vim to access system clipboard)
config.set_environment_variables = {
  TERM = 'wezterm',
}

config.keys = {
  {
    key = 'c',
    mods = 'CMD',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CMD',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

return config
