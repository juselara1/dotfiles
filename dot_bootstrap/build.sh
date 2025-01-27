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
	if [[ ! -f "/usr/local/bin/alacritty" ]]; then
		source /root/.cargo/env
		cargo install alacritty
		mv /root/.cargo/bin/alacritty /usr/local/bin/alacritty
	fi
}

fzf () {
	git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
	/root/.fzf/install --bin
}

starship() {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}

$*
exit 0
