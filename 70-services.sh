#! /bin/bash

# Process monitor for MOTD
#

source $HOME/.config/motd.conf

if [ "${#SERVICES[@]}" -ne 0 ]; then
	echo "  Services:"

	for p in ${SERVICES[@]}; do
		proc=$(echo "$p" | sed 's/^./[&]/')
		status=$(ps ax | grep -wo "$proc" | uniq)

		if [[ -n $status ]]; then
			dot="\e[38;5;36m●\e[0m"
		else
			dot="\e[38;5;127m●\e[0m"
		fi

		p="\e[0;37m$p\e[0m"

		echo -e "  $dot $p"
	
	done
	echo
fi