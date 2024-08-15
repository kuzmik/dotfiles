local wezterm = require 'wezterm'

local config = {}

config.check_for_updates = false
config.scrollback_lines = 1000000
config.front_end = "WebGpu"
config.quote_dropped_files = "WindowsAlwaysQuoted"

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.cursor_thickness = "1"

config.status_update_interval = 500

config.bold_brightens_ansi_colors = "BrightAndBold"
config.font = wezterm.font_with_fallback { 'MonoLisa', 'MonaSpace' }
config.font_size = 15

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

config.macos_window_background_blur = 30
config.window_background_opacity = 0.9
config.window_decorations = 'RESIZE' -- On macOS, 'RESIZE|INTEGRATED_BUTTONS'
config.window_frame = {
  font = wezterm.font({ family = 'MonoLisa', weight = 'Bold' }),
  font_size = 18,
}

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

-- keybinds
config.leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 1000 }
config.keys = {
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
      args = { '/opt/homebrew/bin/subl', wezterm.config_file },
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

-- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = false
config.tab_and_split_indices_are_zero_based = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
  local HOME_DIR = os.getenv('HOME')

  return current_dir.file_path == HOME_DIR and '~'
    or string.gsub(current_dir.file_path, '(.*[/\\])(.*)', '%2')
end

local function tab_title(tab)
  local cwd = get_current_working_dir(tab)
  local title = tab.tab_title

  if title and #title > 0 then
    return title
  end

  return cwd .. ' : ' .. tab.active_pane.title
end

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)

    if tab.is_active then
      return {
        { Background = { Color = '#FFFFFF' } },
        { Foreground = { Color = '#000000' } },
        { Text = ' '.. title .. ' ' },
      }
    end

    return {
      { Background = { Color = '#000000' } },
      { Foreground = { Color = '#b0b0b0' } },
      { Text = ' ' .. title .. ' ' },
    }
  end
)

-- return the config object
return config
