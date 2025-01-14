#!/usr/bin/env bash

install_on_arch() {
	sudo pacman -S --noconfirm ansible
}

install_on_debian() {
	sudo apt update
	sudo apt install -y software-properties-common
	sudo add-apt-repository --yes --update ppa:ansible/ansible
	sudo apt install -y ansible
}

install_on_ubuntu() {
	install_on_debian
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
