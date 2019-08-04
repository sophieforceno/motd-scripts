#! /bin/bash

# Display Pihole stats on MOTD
#

if [[ $(which pihole) ]]; then
	source $HOME/.config/motd.conf
	IFS=$'\n'

	domainsBlocked=$(pihole -c -j | awk -F : '/domains_/ { print $2 }' | cut -d , -f1)
	dnsQueries=$(pihole -c -j | awk -F : '/dns_/ { print $3 }' | cut -d , -f1)
	adsBlocked=$(pihole -c -j | awk -F : '/blocked_/ { print $4 }' | cut -d , -f1)
	adsPercent=$(pihole -c -j | awk -F : '/percentage_/ { print $5 }' | tr -d '}')

	echo -e " Pihole statistics:"
	domainsBlocked="\e[0;37m$domainsBlocked\e[0m"
	echo -e "  Domains blocked: $domainsBlocked"
	dnsQueries="\e[0;37m$dnsQueries\e[0m"
	echo -e "  DNS Queries: $dnsQueries"
	adsBlocked="\e[0;37m$adsBlocked\e[0m"
	echo -e "  Ads blocked: $adsBlocked"
	adsPercent="\e[0;37m$adsPercent\e[0m"
	echo -e "  Percent Ads: $adsPercent"
	echo
fi