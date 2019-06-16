#! /bin/bash

# Hostname banner for MOTD
#

source $HOME/.config/motd.conf

color="\e[30;1;125m"
reset="\e[0m"

if [ -n $(which figlet) ]; then
	printf "${color}"
	figlet -c -w 100 -f lean "$(hostname)"
	printf "${reset}"
fi