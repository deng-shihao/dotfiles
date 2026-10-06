require('aerial').setup {
  backends = { 'lsp', 'treesitter' },
  layout = {
    min_width = 30,
    max_width = { 40, 0.2 },
  },
  attach_mode = 'global',
  filter_kind = false,
  guides = {
    mid_item = '├ ',
    last_item = '└ ',
    nested_top = '│ ',
    whitespace = '  ',
  },
}

vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle<cr>', { desc = 'Toggle Outline' })
