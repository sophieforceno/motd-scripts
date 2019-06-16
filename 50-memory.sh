#! /bin/bash

# Free memory bar graph for MOTD
#

percentUsed=$(vmstat -s | awk ' $0 ~ /total memory/ {total=$1 } $0 ~/free memory/ {free=$1} $0 ~/buffer memory/ {buffer=$1} $0 ~/cache/ {cache=$1} END{print (total-free-buffer-cache)/total*100}')
percentUsed=$(echo ${percentUsed%.*})
total=$(vmstat -s | awk '/total memory/ { total=$1 } END { print total/1024 }')
used=$(vmstat -s | awk ' $0 ~ /total memory/ {total=$1 } $0 ~/free memory/ {free=$1} $0 ~/buffer memory/ {buffer=$1} $0 ~/cache/ {cache=$1} END { print (total-free-buffer-cache)/1024 }')

barWidth=50
clear="\e[39m\e[0m"
dim="\e[2m"
barclear=""
usedBarWidth=$((($percentUsed*$barWidth)/100))
barContent=""
color="36m"
 # Color when $percentUsage is 0-49

if [[ "${percentUsed}" -ge 50 && "${percentUsed}" -lt 90 ]]; then
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

printf '  RAM Usage:%+40s\n' "$used / $total ($percentUsed%)"
echo -e "  ${bar}"

echo