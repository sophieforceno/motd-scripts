#! /bin/bash

# Process monitor for MOTD
#

source $HOME/.config/motd.conf

# TODO: Add a new loop to format into columns when > 5 services

if [ "${#SERVICES[@]}" -ne 0 ]; then
	echo "  Services:"

	for p in ${SERVICES[@]}; do
		proc=$(echo "$p" | sed 's/^./[&]/')
		status=$(ps ax | grep -iwo "$proc" | uniq)

# Change dot color to indicate service status up/down
		if [[ -n $status ]]; then
			dot="\e[38;5;36m●\e[0m"
		else
			dot="\e[38;5;198m●\e[0m"
		fi

		p="\e[0;37m$p\e[0m"

		echo -e "  $dot $p"
	
	done
	echo
fi
