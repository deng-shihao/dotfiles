return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('rose-pine').setup {
      styles = {
        italic = false,
        transparency = true,
      },
    }
    vim.cmd.colorscheme 'rose-pine-dawn'
  end,
}
