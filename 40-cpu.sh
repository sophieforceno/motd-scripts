#! /bin/bash

# CPU Usage for MOTD
#

barWidth=50
clear="\e[39m\e[0m"
dim="\e[2m"
barclear=""

percentUsed=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) " "; }' <(grep -w "cpu" /proc/stat) <(sleep 0.5;grep -w "cpu" /proc/stat))
percentUsed=$(echo ${percentUsed%.*})
percentUsed="40"
usedBarWidth=$((($percentUsed*$barWidth)/100))
barContent=""
color="38;5;36m"

if [[ "${percentUsed}" -gt 44 && "${percentUsed}" -le 59 ]]; then
	color="38;5;53m"
elif [[ "${percentUsed}" -gt 60 && "${percentUsed}" -le 75 ]]; then
	color="38;5;127m"
  #color="38;5;129m"
elif [[ "${percentUsed}" -gt 75 && "${percentUsed}" -le 100 ]]; then
	color="38;5;198m"
  #color="38;5;196m"
fi

for sep in $(seq 1 $usedBarWidth); do
  barContent="${barContent}\e[${color}█\e[0m"
done
barContent="${barContent}${clear}${dim}"
for sep in $(seq 1 $(($barWidth-$usedBarWidth))); do
  barContent="${barContent}-"
done
bar="[${barContent}${clear}] $percentUsed%"
echo "  CPU Usage:"
echo -e "  ${bar}"
echo
