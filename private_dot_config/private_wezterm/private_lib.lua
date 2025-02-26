-- ~/.config/wezterm/lib.lua

local configtable = {}

local function configtable.merge_all(...)
  local ret = {}

  for _, tbl in ipairs({...}) do
    for k, v in pairs(tbl) do
      ret[k] = v
    end
  end

  return ret
end

function configtable.flatten_list(list)
  local flattened_list = {}

  for _, item in ipairs(list) do
    if is_list(item) then
      for _, sub_item in ipairs(configtable.flatten_list(item)) do
        table.insert(flattened_list, sub_item)
      end
    else
      table.insert(flattened_list, item)
    end
  end

  return flattened_list
end

return {
  configtable = configtable,
}
