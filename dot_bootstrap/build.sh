#!/usr/bin/env bash

nvim () {
	git clone "https://github.com/neovim/neovim.git" "/tmp/neovim" --depth 1 --branch "${1}"
	pushd "/tmp/neovim"
	make install
	popd
}

picom () {
}

$*
exit 0
