-- ~/.config/wezterm/tabs.lua

local wezterm = require "wezterm"

local config = {}

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
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  local HOME_DIR = os.getenv("HOME")

  return current_dir.file_path == HOME_DIR and "~"
    or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function tab_title(tab)
  local cwd = get_current_working_dir(tab)
  local title = tab.tab_title
  local index = tab.tab_index + 1

  if title and #title > 0 then
    return title
  end

  return index .. ": " .. cwd .. " : " .. tab.active_pane.title .. " "
end

-- function(tab, tabs, panes, config, hover, max_width)
wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
  local title = tab_title(tab)

  if tab.is_active then
    return {
      { Text = title },
    }
  end

  local has_unseen_output = false
  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      has_unseen_output = true
      break
    end
  end

  if has_unseen_output then
    local alert = wezterm.nerdfonts.md_alert
    return {
      { Foreground = { Color = "orange" } },
      { Text = title .. alert },
    }
  end

  return {
    { Text = title },
  }
end)

-- function(tab, pane, tabs, panes, config)
-- wezterm.on("format-window-title", function(tab, _, _, _, _)
--   return tab_title(tab)
-- end)


return config
