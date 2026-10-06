assert(vim.fn.has 'nvim-0.12' == 1, 'This configuration requires Neovim 0.12 or newer')

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('config_pack_hooks', { clear = true }),
  callback = function(event)
    local plugin = event.data
    if plugin.kind ~= 'install' and plugin.kind ~= 'update' then
      return
    end

    if plugin.spec.name == 'LuaSnip' then
      local result = vim.system({ 'make', 'install_jsregexp' }, { cwd = plugin.path, text = true }):wait()
      if result.code ~= 0 then
        vim.notify('LuaSnip build failed:\n' .. result.stderr .. result.stdout, vim.log.levels.ERROR)
      end
    elseif plugin.spec.name == 'nvim-treesitter' then
      -- Install hooks run before packages enter runtimepath.
      vim.schedule(function()
        vim.cmd.packadd 'nvim-treesitter'
        require('nvim-treesitter').update()
      end)
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim.git',
  'https://github.com/MunifTanjim/nui.nvim.git',
  'https://github.com/nvim-mini/mini.icons.git',
  'https://github.com/nvim-mini/mini.nvim.git',
  'https://github.com/rafamadriz/friendly-snippets.git',
  { src = 'https://github.com/L3MON4D3/LuaSnip.git', version = vim.version.range '2' },
  { src = 'https://github.com/saghen/blink.cmp.git', version = vim.version.range '1' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', version = 'main' },
  { src = 'https://github.com/rose-pine/neovim.git', name = 'rose-pine' },
  'https://github.com/mason-org/mason.nvim.git',
  'https://github.com/folke/lazydev.nvim.git',
  'https://github.com/folke/snacks.nvim.git',
  'https://github.com/folke/which-key.nvim.git',
  'https://github.com/folke/noice.nvim.git',
  'https://github.com/folke/flash.nvim.git',
  'https://github.com/folke/todo-comments.nvim.git',
  'https://github.com/stevearc/conform.nvim.git',
  'https://github.com/stevearc/oil.nvim.git',
  'https://github.com/stevearc/aerial.nvim.git',
  'https://github.com/windwp/nvim-autopairs.git',
  'https://github.com/brenoprata10/nvim-highlight-colors.git',
  'https://github.com/lewis6991/gitsigns.nvim.git',
  'https://github.com/nvimdev/lspsaga.nvim.git',
  'https://github.com/rebelot/heirline.nvim.git',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim.git',
  'https://github.com/nvim-neotest/nvim-nio.git',
  'https://github.com/mfussenegger/nvim-dap.git',
  'https://github.com/rcarriga/nvim-dap-ui.git',
  'https://github.com/jay-babu/mason-nvim-dap.nvim.git',
}, { confirm = false })

-- Configure dependencies before their consumers and UI plugins before VimEnter.
require 'plugins.rose-pine'
require 'plugins.mini'
require 'plugins.mason'
require 'plugins.lazydev'
require 'plugins.blink'
require 'plugins.nvim-treesitter'
require 'plugins.snacks'
require 'plugins.which-key'
require 'plugins.noice'
require 'plugins.heirline'
require 'plugins.aerial'
require 'plugins.autopairs'
require 'plugins.colorizer'
require 'plugins.conform'
require 'plugins.debug'
require 'plugins.flash'
require 'plugins.gitsigns'
require 'plugins.lspsaga'
require 'plugins.markdown'
require 'plugins.oil'
require 'plugins.todo-comments'
