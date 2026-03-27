#!/bin/zsh
# macOS Zsh Configuration - 2026 Edition
# This file contains shell configurations for an optimized terminal experience

# ====================
# Essential Tools
# ====================

# FZF - Fuzzy finder for files and command history
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh

    # FZF configuration
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# zoxide - Smart cd replacement that learns your habits
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    # Use 'z' to jump to directories, 'zi' for interactive selection
fi

# Starship - Modern, minimal prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# ====================
# Shell Options
# ====================

# Enable better globbing
setopt EXTENDED_GLOB

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space

# ====================
# Aliases
# ====================

# Modern replacements (if you want to install these tools)
# brew install eza bat fd ripgrep
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza --icons -l'
    alias la='eza --icons -la'
fi

if command -v bat &> /dev/null; then
    alias cat='bat'
fi

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# VSCode shortcut
alias code='code .'

# Quick directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ====================
# Environment Variables
# ====================

# Set default editor
export EDITOR='code -w'
export VISUAL='code -w'

# Add common paths (customize as needed)
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# ====================
# Completion System
# ====================

# Enable completion system
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Better completion menu
zstyle ':completion:*' menu select
