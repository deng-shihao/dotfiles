require('snacks').setup(require 'plugins.snacks.opts')
require('plugins.snacks.toggles').setup()

for _, keymap in ipairs(require 'plugins.snacks.keys') do
  local opts = vim.deepcopy(keymap)
  local mode = opts.mode or 'n'
  opts[1], opts[2], opts.mode = nil, nil, nil
  vim.keymap.set(mode, keymap[1], keymap[2], opts)
end
