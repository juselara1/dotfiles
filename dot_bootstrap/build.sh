#!/usr/bin/env bash

nvim () {
	if [[ ! -f "/usr/local/bin/nvim" ]]; then
		git clone "https://github.com/neovim/neovim.git" "/tmp/neovim" --depth 1 --branch "${1}"
		pushd "/tmp/neovim"
		make install
		popd
	fi
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

starship () {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}

picom () {
	git clone --depth 1 https://github.com/yshui/picom /tmp/picom
	pushd /tmp/picom
	meson setup --buildtype=release build
	ninja -C build install
	popd
}

$*
exit 0
