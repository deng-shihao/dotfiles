local severity = vim.diagnostic.severity

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
})

vim.lsp.enable {
  'lua_ls',
  'clangd',
  'basedpyright',
  'marksman',
  'ruff',
  'cmake',
  'vtsls',
  'tinymist',
}

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [severity.ERROR] = '󰅚 ',
      [severity.WARN] = '󰀪 ',
      [severity.INFO] = '󰋽 ',
      [severity.HINT] = '󰌶 ',
    },
    numhl = {
      [severity.ERROR] = 'ErrorMsg',
      [severity.WARN] = 'WarningMsg',
    },
  },
}
