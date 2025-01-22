#!/usr/bin/env bash

# ================================================================================
# pyenv
if [[ -d "/usr/local/bin/pyenv" ]]; then
    eval "$(pyenv init -)"
fi

# ================================================================================
# fzf
if [[ -f "/usr/local/bin/fzf" ]]; then
	eval "$(fzf --bash)"
fi

# ================================================================================
# zoxide
if [[ -f "/usr/local/bin/zoxide" ]]; then
	eval "$(zoxide init bash)"
fi

# ================================================================================
# starship
if [[ -f "/usr/local/bin/starship" ]]; then
	eval "$(starship init bash)"
fi
