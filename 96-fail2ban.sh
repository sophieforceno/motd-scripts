#! /bin/bash

# Count IPs banned by fail2ban for MOTD
#

if [[ $(which fail2ban-server 2> /dev/null) ]]; then

	source $HOME/.config/motd.conf

	IFS=$'\n'

#	echo "  Banned IPs:"
	bannedCount=( $(sudo awk '($(NF-1) = /Ban/){ print $1 "\t" $NF }' "$f2blog" | grep "$(date +%Y-%m-%d)" | awk '{ print $2 }' | uniq | wc -l) ) 
#	echo ${BANNED[@]}
#	for ip in ${BANNED[@]}; do
		#echo "  $ip"
#	done

	bannedCount="\e[0;37m$bannedCount\e[0m"
	echo -e "  IPs banned today: $bannedCount"
	echo
fi