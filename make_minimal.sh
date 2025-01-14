#!/usr/bin/env bash

function clean() {
	local elements=("run_once_install_ansible.sh" "run_fix_permissions.sh" "dot_wallpaper.jpg" "dot_xinitrc" "dot_bootstrap" dot_config/{alacritty,awesome,picom,polybar})
	for elem in "${elements[@]}"; do
		rm -rf "${elem}"
	done
}

function commit() {
	git add -A
	git commit -m "feat(minimal): configuration to minimal version."
}

clean
commit
