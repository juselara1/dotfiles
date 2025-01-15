#!/usr/bin/env bash

install_on_arch() {
	sudo pacman -S --noconfirm ansible
}

get_os_name() {
	cat /etc/os-release | grep -P '^ID=' | awk -F '=' '{print tolower($2)}'
}

main() {
	eval "install_on_`get_os_name`"
	ansible-galaxy collection install kewlfft.aur
	ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass
}

main
