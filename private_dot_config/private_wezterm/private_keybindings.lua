local wezterm = require 'wezterm'

local config = {}

config.leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { '/opt/homebrew/bin/subl', wezterm.config_file },
    },
  },
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action{SendString="\x1bb"}
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action{SendString="\x1bf"}
  },
  -- kitty-like bindings
  {
    key = 'd',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'SUPER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'r',
    mods = 'SUPER',
    action = wezterm.action.ActivateKeyTable({
       name = 'resize_pane',
       one_shot = false,
       timemout_miliseconds = 1000,
    }),
  },
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'activate_pane',
      timeout_milliseconds = 1000,
    },
  },
  -- pane navigation
  {
    key = 'UpArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Up'
  },
  {
    key = 'DownArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Down'
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Left'
  },
  {
    key = 'RightArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Right'
  },
}

config.key_tables = {
  resize_pane = {
    { key = 'UpArrow', action = wezterm.action.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'DownArrow', action = wezterm.action.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'LeftArrow', action = wezterm.action.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'RightArrow', action = wezterm.action.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

return config
