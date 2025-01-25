#!/usr/bin/env bash

nvim () {
	git clone "https://github.com/neovim/neovim.git" "/tmp/neovim" --depth 1 --branch "${1:v0.10.0}"
	pushd "/tmp/neovim"
	make install
	popd
}

$*
exit 0
