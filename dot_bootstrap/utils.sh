#!/usr/bin/env bash

is_wsl () {
	if [[ `grep -i Microsoft /proc/version` ]]; then
		echo "true"
	else
		echo "false"
	fi
}

$*
exit 0
