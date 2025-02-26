-- ~/.config/wezterm/hyperlinks.lua

local wezterm = require 'wezterm'

local config = {}

-- open hyperlinks from rg (and others hopefully)
local function filelink_click(win, pane, uri)
  local prefix  = 'file-line-column://' -- 'file-line-column:///path/to/file.txt:ln:col'
  -- the exact scheme of the URL depends on the editor, so ↑ and editor arguments ↓ need to be adjusted to reflect that
  -- https://github.com/dandavison/open-in-editor/blob/master/open-in-editor
  local prefix_re = prefix:gsub("([^%w])", "%%%1") -- escape -:/
  local prefix_beg, prefix_end = uri:find('^' .. prefix_re)

  if prefix_beg == 1 then
    local editor_cli = '/opt/homebrew/bin/subl'
    local uri_target = uri:sub(prefix_end + 1)
    -- spawncommandinnewwindow will popup a new window, but it will disappear. less annotying than
    -- switching to the last tab
    win:perform_action(wezterm.action.SpawnCommandInNewWindow {
      args = { editor_cli, uri_target }
    }, pane)

    return false
  end
end

wezterm.on('open-uri', filelink_click)

-- i really just wanted to get rid of the email links here
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = '\\((\\w+://\\S+)\\)',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = '\\[(\\w+://\\S+)\\]',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = '\\{(\\w+://\\S+)\\}',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = '<(\\w+://\\S+)>',
    format = '$1',
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    regex = '[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)',
    format = '$1',
    highlight = 1,
  },
}

return config
