local languages = {
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'diff',
  'fish',
  'html',
  'java',
  'javascript',
  'typescript',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'scss',
  'svelte',
  'tsx',
  'typst',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

require('nvim-treesitter').install(languages)
vim.treesitter.language.register('bash', 'zsh')

local configured = {}
for _, lang in ipairs(languages) do
  configured[lang] = true
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config_treesitter_start', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if configured[lang] then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})
