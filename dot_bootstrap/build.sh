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
	if [[ ! -f "/usr/local/bin/fzf" ]]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
		/root/.fzf/install --bin
		mv /root/.fzf/bin/fzf /usr/local/bin/fzf
	fi
}

starship () {
	curl -sS https://starship.rs/install.sh | sh -s -- -y
}

picom () {
	if [[ ! -f "/usr/local/bin/picom" ]]; then
		git clone --depth 1 https://github.com/yshui/picom /tmp/picom
		pushd /tmp/picom
		meson setup --buildtype=release build
		ninja -C build install
		popd
	fi
}

docker-ubuntu () {
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	chmod a+r /etc/apt/keyrings/docker.asc

	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt update
}

docker-debian () {
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
	chmod a+r /etc/apt/keyrings/docker.asc

	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt-get update
}

monaspace () {
	git clone --depth 1 https://github.com/githubnext/monaspace.git /tmp/monaspace
	pushd /tmp/monaspace
	bash util/install_linux.sh
	popd
}

$*
exit 0
