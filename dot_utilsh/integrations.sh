#!/usr/bin/env bash

# ================================================================================
# pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PATH="$PATH:$HOME/.pyenv/bin/"
    eval "$(pyenv init -)"
fi

# ================================================================================
# fzf
if command -v fzf > /dev/null 2>&1; then
	eval "$(fzf --bash)"
fi

# ================================================================================
# starship
if command -v starship > /dev/null 2>&1; then
	eval "$(starship init bash)"
fi

# ================================================================================
# zoxide
if command -v zoxide > /dev/null 2>&1; then
	eval "$(zoxide init bash)"
fi
