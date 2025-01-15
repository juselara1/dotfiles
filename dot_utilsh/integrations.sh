#!/usr/bin/env bash

# ================================================================================
# pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PATH="$PATH:$HOME/.pyenv/bin/"
    eval "$(pyenv init -)"
fi
