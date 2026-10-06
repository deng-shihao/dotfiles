require('conform').setup {
  notify_on_error = false,
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format' },
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

vim.keymap.set('', '<leader>cf', function()
  require('conform').format { async = true }
end, { desc = 'Format Buffer' })
