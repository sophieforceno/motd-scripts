	#!/bin/bash

# Displays disk usage as horizontal bar graph
# Adapted from: https://github.com/RIKRUS/MOTD
#

source $HOME/.config/motd.conf

barWidth=50
maxDiscUsage=90
clear="\e[39m\e[0m"
dim="\e[2m"
barclear=""

echo "  Disks:"
for point in "${MOUNTPOINTS[@]}"; do
    line=$(df -h "${point}")
    percentUsed=$(echo "$line"|tail -n1|awk '{print $5;}'|sed 's/%//')
    usedBarWidth=$((($percentUsed*$barWidth)/100))
    barContent=""
    color="36m"

	if [[ "${percentUsed}" -ge 70 && "${percentUsed}" -lt 90 ]]; then
		color="127m"
	elif [[ "${percentUsed}" -ge 90 && "${percentUsed}" -le 100 ]]; then
		color="1;31m"
	fi

    for sep in $(seq 1 $usedBarWidth); do
        barContent="${barContent}\e[38;5;${color}█\e[0m"
    done
    barContent="${barContent}${clear}${dim}"
    for sep in $(seq 1 $(($barWidth-$usedBarWidth))); do
        barContent="${barContent}-"
    done
    bar="[${barContent}${clear}]"
	echo "  ${line}" | awk  '{if ($1 != "Filesystem") printf("%-32s%+3s / %+3s (%+2s)\n", $6, $3, $2, $5); }' | sed -e 's/^/  /'
	echo -e "${bar}" | sed -e 's/^/  /'
done

echo