#!/usr/bin/env bash

# Browser
get_firefox() {
	local profiles=`cat "${HOME}/.mozilla/firefox/profiles.ini" | grep -P 'Name=' | sed 's/Name=//g'` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Firefox profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && firefox -p "${selected_profile}" &
}

get_qutebrowser() {
	local profiles=`ls "${HOME}/.qutebrowser/"` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Qutebrowser profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && qutebrowser --basedir "${HOME}/.qutebrowser/${selected_profile}" &
}

get_chrome() {
	google-chrome-stable &
}

browser_menu() {
	local options="firefox\nqutebrowser\nchrome"
	local selected_option=`echo -e "${options}" | fzf --header "Select browser" --height "40%" --layout=reverse`
	eval "get_${selected_option}"
}

# Programs
get_executables() {
	local paths=(`echo "${PATH}" | sed 's/:/\\n/g'`)
	local executables=()
	for path in "${paths[@]}"; do
		[[ -d "${path}" ]] && local executables+=(`ls -p "${path}"`)
	done
	printf "%s\n" `echo ${executables[@]}`
}

programs_menu() {
	local executables=`get_executables`
	local selected_option=`echo -e "${executables}" | fzf --header "Choose program" --height "40%" --layout=reverse`
	eval "${selected_option}"
}

# Templates
get_templates() {
	gh repo list --json nameWithOwner -q 'map(select(.nameWithOwner | test(".*template"))) | .[].nameWithOwner?'
}

templates_menu() {
	local templates=`get_templates`
	local selected_option=`echo -e "${templates}" | fzf --header "Choose a template" --height "40%" --layout=reverse`
	cookiecutter "https://github.com/${selected_option}"
}

# Launcher
launcher_menu () {
	local options="programs\nbrowser\ntemplates"
	local selected_option=`printf "$options" | fzf --header "Choose option" --height "40%" --layout=reverse`
	[[ ! -z "${selected_option}" ]] && eval "${selected_option}_menu"
}
