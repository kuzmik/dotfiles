-- ~/.config/wezterm/customlib.lua

local configtable = {}

function configtable.merge_all(...)
  local ret = {}

  for _, tbl in ipairs({...}) do
    for k, v in pairs(tbl) do
      ret[k] = v
    end
  end

  return ret
end

return {
  configtable = configtable,
}
