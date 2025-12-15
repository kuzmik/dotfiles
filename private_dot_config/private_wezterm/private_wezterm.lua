-- ~/.config/wezterm/wezterm.lua

-- docs:
--  https://wezfurlong.org/wezterm/config/files.html
--  https://wezfurlong.org/wezterm/config/lua/general.html

-- TODOs:
--  1. maybe style the tabs a little nicer; look into the retro styling i guess. the close button bugs me

local wezterm = require "wezterm"
local configtable = require("customlib").configtable

local config = {}

-- general config stuff
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.check_for_updates = false
config.quote_dropped_files = "WindowsAlwaysQuoted"
config.scrollback_lines = 1000000
config.status_update_interval = 500

-- show which key table is active in the status area
wezterm.on("update-right-status", function(window, _)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

-- return the merged config objects
return configtable.merge_all(
  config,
  require("appearance"),
  require("clipboard"),
  require("hyperlinks"),
  require("keybindings"),
  require("tabs"),
  {}
)
