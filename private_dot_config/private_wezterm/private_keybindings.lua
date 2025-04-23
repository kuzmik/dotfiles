-- ~/.config/wezterm/keybindings.lua

local wezterm = require 'wezterm'

local leader = {
  key = 'a',
  mods = 'CMD',
  timeout_milliseconds = 1000
}

local keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { '/opt/homebrew/bin/subl', wezterm.config_dir },
    },
  },
  -- force new tabs to open in ~, otherwise they will open in the CWD of whatever tab
  -- you were in when you spawned the new one
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
    },
  },
  -- make alt+left/right move to start/end of words, like a sane shell
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action { SendString="\x1bb" }
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action { SendString="\x1bf" }
  },
  -- kitty-like pane bindings
  {
    key = 'D',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
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
    key = 'r',
    mods = 'CTRL|ALT',
    action = wezterm.action.ResetTerminal,
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
  -- tab manipulation (move them around)
  {
    key = '{',
    mods = 'SHIFT|ALT',
    action = wezterm.action.MoveTabRelative(-1)
  },
  {
    key = '}',
    mods = 'SHIFT|ALT',
    action = wezterm.action.MoveTabRelative(1)
  },
}

local key_tables = {
  -- kitty like pane resizing. CMD-R and up/down/left/right to size the selected pane
  resize_pane = {
    { key = 'UpArrow', action = wezterm.action.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'DownArrow', action = wezterm.action.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'LeftArrow', action = wezterm.action.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'RightArrow', action = wezterm.action.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  -- overide single click so that it doesnt open links without CMD
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  -- cmd-click will open the link under the mouse cursor
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- stop the window dragging
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'SHIFT|CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return {
  key_tables = key_tables,
  keys = keys,
  mouse_bindings = mouse_bindings,
  leader = leader,
}
