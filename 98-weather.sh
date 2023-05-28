#! /bin/bash

source $HOME/.config/motd.conf

wttrfmt="%l%20%t%20%h%20%w%20%p%20%u%20%c"
weather=$(curl -s -f "https://wttr.in/$location?format=$wttrfmt"| column -t)

echo -n "  Weather conditions |"; echo -e "\e[0;37m $(date '+%a %b %d %H:%M') \e[0m"
echo "    Location    Temp. Humid. Wind Precip. UV Condition"
echo -e "   \e[0;37m $weather \e[0m\n"
