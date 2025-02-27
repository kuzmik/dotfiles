-- ~/.config/wezterm/hyperlinks.lua

local wezterm = require 'wezterm'

local config = {}

-- open hyperlinks from rg (and others hopefully)
local function filelink_click(win, pane, uri)
  local prefix = 'file-line-column://'
  local prefix_re = prefix:gsub("([^%w])", "%%%1") -- escape special chars
  local prefix_beg, prefix_end = uri:find('^' .. prefix_re)

  -- Check if this is our file URI format
  if not uri:find('^' .. prefix_re) then
    return true -- Not our URI scheme, let something else handle it
  end

  local uri_target = uri:sub(#prefix + 1)

  -- Extract path, line, column using pattern matching
  local path, line, column = uri_target:match("(.+):(%d+):(%d+)$")

  if not path then
    path, line = uri_target:match("(.+):(%d+)$")
    column = "1"
  end

  if not path then
    -- No line or column info, use some default values
    path = uri_target
    line = "1"
    column = "1"
  end

  -- Choose editor based on availability
  local editors = {
    { cmd = '/usr/local/bin/cursor', args = {'-g', path .. ":" .. line .. ":" .. column} },
    { cmd = '/opt/homebrew/bin/subl', args = {path .. ":" .. line .. ":" .. column} },
    { cmd = '/opt/homebrew/bin/nvim', args = {'+' .. line, path} }
  }

  for _, editor in ipairs(editors) do
    local exists = editor.cmd == 'vim' or io.open(editor.cmd, "r")
    if exists then
      if io.type(exists) == 'file' then io.close(exists) end

      win:perform_action(wezterm.action.SpawnCommandInNewWindow {
        args = { editor.cmd, table.unpack(editor.args) }
      }, pane)

      return false
    end
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
