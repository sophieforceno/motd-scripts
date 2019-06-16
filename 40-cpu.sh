#! /bin/bash

# CPU Usage for MOTD
# The awk solution was found on Stackoverflow, but of course I can't find it now. It's floating out there.
#

barWidth=50
clear="\e[39m\e[0m"
dim="\e[2m"
barclear=""

percentUsed=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) " "; }' <(grep -w "cpu" /proc/stat) <(sleep 0.5;grep -w "cpu" /proc/stat))
percentUsed=$(echo ${percentUsed%.*})

usedBarWidth=$((($percentUsed*$barWidth)/100))
barContent=""
color="38;5;36m"

if [[ "${percentUsed}" -ge 70 && "${percentUsed}" -lt 89 ]]; then
  color="38;5;129m"
elif [[ "${percentUsed}" -ge 90 && "${percentUsed}" -le 100 ]]; then
  color="38;5;196m"
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