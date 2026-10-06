local colored_fts = {
  'cfg',
  'css',
  'html',
  'conf',
  'lua',
  'scss',
  'toml',
  'tmux',
  'xml',
  'kitty',
  'markdown',
  'python',
  'typescript',
  'typescriptreact',
}

local configured = false
local function setup()
  if configured then
    return
  end
  require('nvim-highlight-colors').setup {
    render = 'virtual',
    virtual_symbol = '󱓻',
  }
  configured = true
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config_highlight_colors', { clear = true }),
  pattern = colored_fts,
  once = true,
  callback = setup,
})

vim.keymap.set('n', ',c', function()
  setup()
  vim.cmd.HighlightColors 'Toggle'
end, { silent = true, desc = 'Toggle colorizer' })
