#! /bin/bash

source $HOME/.config/motd.conf

getdate() { 
	date | awk '{print $1, $2, $3}'
}

getweather(){ 
	curl -s -f "https://wttr.in/$location?format=%l%20%t%20%h%20%w%20%p%20%u%20%c"| column -t
}

weather=$(getweather)
gdate=$(getdate)

echo -n "  Current weather conditions | "; echo -e "\e[0;37m $gdate\e[0m"
echo "    Location    Temp. Humid. Wind Precip. UV Condition"
echo -e "   \e[0;37m $weather \e[0m\n"
