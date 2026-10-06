# Neovim configuration

Requires Neovim 0.12+, Git, and a C compiler with `make` for LuaSnip's regexp support.
Treesitter also needs `curl`, `tar`, and the `tree-sitter` CLI.
Mason continues to manage language servers, formatters, and debugger tools.

Plugins use Neovim's built-in [`vim.pack`](https://github.com/neovim/neovim/blob/v0.12.5/runtime/doc/pack.txt).
`lua/config/pack.lua` registers packages and loads their configuration modules directly.
Packages load at startup. Plugin options and keymaps remain in `lua/plugins/`.
LSP bootstrap stays in `lua/config/lsp.lua`, with server definitions in `lsp/`.
`init.lua` enables Neovim's native [Lua bytecode cache](https://github.com/neovim/neovim/blob/v0.12.5/runtime/doc/lua.txt#L3414) to reduce startup work.

Treesitter installs parsers for the configured primary LSP languages and the listed web and shell formats.
Fish uses its own parser; Zsh uses Bash's parser.
The YAML parser supports Markdown frontmatter.

`nvim-pack-lock.json` preserves the previous plugin revisions. Keep it in version control.
Neovim generates this file; do not edit it manually.
Blink follows 1.x releases, LuaSnip follows 2.x releases, and Treesitter follows `main`.
Other plugins follow their default branches when updated.

Use these commands inside Neovim:

| Action | Command |
| --- | --- |
| Review plugin updates | `:lua vim.pack.update()` |
| Inspect packages without fetching | `:lua vim.pack.update(nil, { offline = true })` |
| Restore installed revisions from the lockfile | `:lua vim.pack.update(nil, { target = 'lockfile' })` |
| Check package health | `:checkhealth vim.pack` |

In the review buffer, use `:write` to apply changes or `:quit` to cancel. Restart after updates.
`<leader>sp` searches plugin configuration files.
The `PackChanged` hook rebuilds LuaSnip's regexp support and updates Treesitter parsers after package changes.

The old `lazy.nvim` cache remains on disk for rollback. This configuration does not load it.
