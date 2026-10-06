local icons = require 'config.icons'

local function key(icon, key, desc, action, extra)
  return vim.tbl_extend('force', {
    icon = icon.icon,
    icon_hl = icon.hl,
    key = key,
    desc = desc,
    action = action,
  }, extra or {})
end

return {
  enabled = false,
  formats = {
    icon = function(item)
      return { item.icon, width = 2, hl = item.icon_hl or 'icon' }
    end,
  },
  preset = {
    keys = {
      key(icons.dashboard.FindFile, 'f', 'Find File', ":lua Snacks.dashboard.pick('files')"),
      key(icons.dashboard.NewFile, 'n', 'New File', ':ene | startinsert'),
      key(icons.dashboard.FindText, 'g', 'Find Text', ":lua Snacks.dashboard.pick('live_grep')"),
      key(icons.dashboard.RecentFiles, 'r', 'Recent Files', ":lua Snacks.dashboard.pick('oldfiles')"),
      key(icons.dashboard.Config, 'c', 'Config', ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"),
      key(icons.dashboard.Mason, 'm', 'Mason', ':Mason'),
      key(icons.dashboard.Packages, 'l', 'Packages', function()
        vim.pack.update(nil, { offline = true })
      end),
      key(icons.dashboard.Quit, 'q', 'Quit', ':qa'),
    },
  },
  sections = {
    { section = 'header' },
    { section = 'keys', gap = 1, padding = 1 },
    function()
      local active, total = 0, 0
      for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
        total = total + 1
        active = active + (plugin.active and 1 or 0)
      end
      return { text = ('Neovim loaded %d/%d plugins'):format(active, total), align = 'center' }
    end,
  },
}
