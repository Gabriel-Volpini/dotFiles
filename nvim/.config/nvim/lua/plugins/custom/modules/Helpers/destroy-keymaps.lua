---@alias Keymap {string: string}
---@alias data Keymap[]
---@param maps {n?: data, v?: data, i?: data}
return function(maps)
  for mode, keymaps in pairs(maps) do
    for _, keymap in ipairs(keymaps) do
      pcall(vim.keymap.del, mode, keymap[1])
    end
  end
end
