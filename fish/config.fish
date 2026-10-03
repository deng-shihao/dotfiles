# fish/config.fish
# @author deng
# since 2024 2025 2026

# Cute startup greeting.
# Rosé Pine hexes are baked in: the greeting is printed before fish resolves
# fish_terminal_color_theme, so it cannot follow the light/dark theme variant.
# rose/iris/love were picked to stay legible on both Dawn and the night base.
function _fish_greeting
    set -l rose (set_color --bold d7827e)
    set -l iris (set_color 907aa9)
    set -l love (set_color b4637a)
    set -l off (set_color normal)
    printf '%sNyaa~ %sterminal ready! %s(^._.^)~ %s<3%s\n' \
        $rose $iris $rose $love $off
end
set -g fish_greeting (_fish_greeting)

# Default editor.
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

# Homebrew environment.
if test -x /opt/homebrew/bin/brew; and not set -q HOMEBREW_PREFIX
    eval (/opt/homebrew/bin/brew shellenv)
end

# Keep Homebrew tools ahead of macOS system shims even when HOMEBREW_PREFIX is inherited.
fish_add_path --global /opt/homebrew/bin /opt/homebrew/sbin

# User and package paths.
fish_add_path --global \
    $HOME/.local/bin \
    $HOME/.opencode/bin \
    /opt/homebrew/opt/openjdk@21/bin
if test -d "$HOME/.lmstudio/bin"
    fish_add_path --global --append "$HOME/.lmstudio/bin"
end

# fzf defaults.
if command -q rg
    set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --glob '!.git'"
end
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --cycle --preview-window=wrap"

# Keep non-interactive shells lightweight.
status is-interactive; or return

# Theme (Rosé Pine Dawn on light terminals, Rosé Pine on dark).
fish_config theme choose rosepine

# Directory listing aliases.
if command -q eza
    alias l.="eza -a"
    alias ls="eza -F --sort=type --icons=always"
    alias ll="eza -aF --long --sort=type --icons=always"
    alias lt4="eza -lT -L4 --icons"
end

if command -q opencode
  alias oc="opencode"
end

# Small command shortcuts.
abbr --add --position command -- '~' 'cd ~'
alias ..="cd .."
alias c="clear"
alias ff="fastfetch"
alias vi="nvim"
alias vim="nvim"
alias gst="git status"
alias cfg="cd ~/.config"
if command -q claude
    alias cc="claude --dangerously-skip-permissions"
end
alias 哈吉米="cat"

# Default Fish key bindings.
fish_default_key_bindings

# Shell navigation shortcuts.
bind ctrl-p history-search-backward
bind ctrl-n history-search-forward
bind ctrl-a beginning-of-line
bind ctrl-e end-of-line
bind ctrl-f accept-autosuggestion
bind alt-w kill-selection

# Smarter cd.
if command -q zoxide
    zoxide init --cmd cd fish | source
end

# Prompt.
if command -q starship
    starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

