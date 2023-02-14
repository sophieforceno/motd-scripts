#! /bin/bash

# List SSL certificate expiration for MOTD
# 

source $HOME/.config/motd.conf

check_cache() {
	if [ ! -e /tmp/.motdcache ]; then
		touch /tmp/.motdcache
		cached=0
		get_dates 
	else
		cached=1
		for l in "$(< /tmp/.motdcache)"; do
		  	CACHED_DOMAINS=( $(echo "$l" | awk '{ print $1 }' | tr '\n' ' ') )
		  	CACHED_DATE=( $(echo "$l" | awk '{ print $2 }' | tr '\n' ' ') )
		  	CACHED_EXPIRY=( $(echo "$l" | awk '{ print $3 }' | tr '\n' ' ') )
		done

		dateNow=$(date +%s)

		for date in "${CACHED_DATE[@]}"; do
			dateDiff=$((dateNow-date))
			# Refresh cache daily
			if [[ "$dateDiff" -gt 259200 ]]; then
				cached=0
				# Re-cache expiry dates
				get_dates
			fi
		done
	fi
}

get_dates() {
	rm /tmp/.motdcache
	touch /tmp/.motdcache
	for d in "${DOMAINS[@]}"; do
		expiry=$(curl --insecure -v https://$d 2>&1 | grep "expire date" | cut -d ' ' -f5-)
		# Deprecated, will be removed at a later date
		#expiry=$(curl --insecure -v https://$d 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }' | awk '/expire/ {i = 3; for (--i; i >= 0; i--){ printf "%s ",$(NF-i)} print ""}')
		expirySecs=$(date -d "$expiry" "+%s")
		dateNow=$(date +%s)
		dateDiff=$((expirySecs-dateNow))
		echo "$d $dateNow $expirySecs" >> /tmp/.motdcache 
	done
}

## Main
if [[ "${#DOMAINS[@]}" -gt 0 ]]; then
	echo "  Domains:"
	check_cache
	# If we came directly from check_cache(), we have a different array
	if [[ "$cached" -eq 1 ]]; then
		for index in ${!CACHED_DOMAINS[*]}; do
			if ! test "$dateDiff" -gt 0; then
				dot="\e[38;5;127m●\e[0m"
			else
				dot="\e[38;5;36m●\e[0m"
			fi
			expiryString="${CACHED_EXPIRY[$index]}"
			echo -e "  $dot ${CACHED_DOMAINS[$index]}: \e[0;37m$(date -d @$expiryString)\e[0m"
		done
	echo
	# Otherwise we came from get_dates()
	elif [[ "$cached" -eq 0 ]]; then
		for d in ${DOMAINS[@]}; do
			# If dateDiff is negative, set dot color to purple
			if ! test "$dateDiff" -gt 0; then
				dot="\e[38;5;127m●\e[0m"
			else
				dot="\e[38;5;36m●\e[0m"
			fi
			expiry="\e[0;37m$expiry\e[0m"
			echo -e "  $dot $d: $expiry"
		done
	echo
	fi
fi
