#!/usr/bin/env bash

nvim () {
	git clone "https://github.com/neovim/neovim.git" "/tmp/neovim" --depth 1 --branch "${1}"
	pushd "/tmp/neovim"
	make install
	popd
}

rust () {
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	source /root/.cargo/env
}

alacritty () {
	source /root/.cargo/env
	cargo install alacritty
	mv /root/.cargo/bin/alacritty /usr/local/bin/alacritty
}

fzf () {
	git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
	/root/.fzf/install --bin
	mv /usr/bin/fzf /usr/local/bin/fzf
}

$*
exit 0
