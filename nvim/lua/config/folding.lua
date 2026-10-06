-- Folding
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

local group = vim.api.nvim_create_augroup('config_folding', { clear = true })

local function update_folding(bufnr)
  local clients = vim.lsp.get_clients { bufnr = bufnr, method = 'textDocument/foldingRange' }
  local expr = #clients > 0 and 'v:lua.vim.lsp.foldexpr()' or 'v:lua.vim.treesitter.foldexpr()'
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.wo[win].foldexpr = expr
  end
end

vim.api.nvim_create_autocmd({ 'LspAttach', 'BufWinEnter' }, {
  group = group,
  desc = 'Select folding for the displayed buffer',
  callback = function(ev)
    update_folding(ev.buf)
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = group,
  desc = 'Restore folding after the client detaches',
  callback = function(ev)
    -- LspDetach runs before the client leaves the buffer's client list.
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        update_folding(ev.buf)
      end
    end)
  end,
})

local function fold_virt_text(result, start_text, lnum)
  local text = {}
  local hl
  local i = 1
  while i <= #start_text do
    local last = i + vim.str_utf_end(start_text, i)
    local char = start_text:sub(i, last)
    local new_hl

    -- if semantic tokens unavailable, use treesitter hl
    local sem_tokens = vim.lsp.semantic_tokens.get_at_pos(0, lnum, i - 1)
    if sem_tokens and #sem_tokens > 0 then
      new_hl = '@' .. sem_tokens[#sem_tokens].type
    else
      local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
      if captured_highlights[#captured_highlights] then
        new_hl = '@' .. captured_highlights[#captured_highlights].capture
      end
    end

    if new_hl ~= hl then
      if #text > 0 then
        table.insert(result, { table.concat(text), hl })
      end
      text = {}
      hl = new_hl
    end
    if char == '\t' then
      local prefix = vim.fn.strdisplaywidth(start_text:sub(1, i - 1))
      char = string.rep(' ', vim.fn.strdisplaywidth('\t', prefix))
    end
    text[#text + 1] = char
    i = last + 1
  end
  if #text > 0 then
    table.insert(result, { table.concat(text), hl })
  end
end
function _G.custom_foldtext()
  local start_text = vim.fn.getline(vim.v.foldstart)
  local nline = vim.v.foldend - vim.v.foldstart + 1
  local result = {}
  fold_virt_text(result, start_text, vim.v.foldstart - 1)
  table.insert(result, { ' ', nil })
  table.insert(result, { '', '@comment.warning.gitcommit' })
  table.insert(result, { nline .. ' lines', '@comment.warning' })
  table.insert(result, { '', '@comment.warning.gitcommit' })
  return result
end
vim.opt.foldtext = 'v:lua.custom_foldtext()'
