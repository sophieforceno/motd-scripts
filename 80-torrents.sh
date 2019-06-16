#! /bin/bash

# Lists actively seeding torrents for MOTD
#

source $HOME/.config/motd.conf

if [[ -n $(which transmission-remote) ]]; then

	IFS=$'\r\n'
	address="http://$transmissionAddr:$transmissionPort/$transmissionDir"
	SEEDING=( $(transmission-remote $address -l | grep Seeding | awk '{out=""; for(i=10;i<=NF;i++){out=out" "$i}; print out}') )
#	STOPPED=( $(transmission-remote $address -l | grep Stopped | awk '{out=""; for(i=10;i<=NF;i++){out=out" "$i}; print out}') )

	if [ ${#SEEDING[@]} -ne 0 ]; then
		echo "  Torrents seeding:"
		for torr in ${SEEDING[@]}; do
			if [[ -z $STY ]]; then
				dot="\e[38;5;36m●\e[0m"
				torr="\e[0;37m$torr\e[0m"
			else
				dot="●"
			fi
				echo -e "  $dot $torr"
		done
	echo
	fi

#if [ ${#STOPPED[@]} -ne 0 ]; then
#	echo "Torrents stopped:"
#	for torr in ${STOPPED[@]}; do                                                                                                                                                                              
#		dot="\e[38;5;127m●\e[0m"                                                                                                                                                                                
#		echo -e "$dot $torr"                                                                                                                                                                                   
#	done
#echo
#fi
fi