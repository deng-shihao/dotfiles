local dap = require 'dap'
local dapui = require 'dapui'
local icons = require 'config.icons'

require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {},
}

dapui.setup {
  icons = icons.dap.ui,
  controls = {
    icons = icons.dap.controls,
  },
}

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#f38ba8' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#f9e2af' })
for type, icon in pairs(icons.dap.breakpoints) do
  local sign = 'Dap' .. type
  local hl = type == 'Stopped' and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(sign, { text = icon .. ' ', texthl = hl, numhl = hl })
end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
