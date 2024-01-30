#! /bin/bash

# CPU temperature display for MOTD
# Adapted from: https://github.com/RIKRUS/MOTD
#

# TODO: Get temps and types from /sys/class/thermal/thermal_zone0/temp
#		and /sys/class/thermal/thermal_zone0/type

if [ -n $(which sensors) ]; then
	source $HOME/.config/motd.conf
	CORES=( $(sensors | awk '{ if ($1=="SoC" || $1=="Core") print $2 }' | tr -d ':')  )
	TEMPS=( $(sensors | awk '{ if ($1=="SoC" || $1=="Core") print $3 }' | tr -d '+°C' | cut -d '.' -f1) )
	gpuTemp=$(sensors | awk 'f { print $2; f=0 } /GPU/{f=1}' | tr -d '+°C')
	gpuTemp=$(echo ${gpuTemp%.*})
	# This is for SBCs such as Raspberry Pi. Tested on Raspberry Pi 4 and Libre AML-S805X-AC (La Frite) 
	miscTemp=$(sensors | grep -E 'thermal|temp1|temp2' | awk '{ print $2 }' | head -2 | tr -d '+°C\n')

	# Otherwise rounding will produce invalid arithmetic operation on devices without "thermal"	
	if [[ "$miscTemp" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
		miscTemp=$(echo ${miscTemp%.*})
	else
		miscTemp=""
	fi

	if [ "${#CORES[@]}" -ne 0 ]; then
		echo "  Temperature:"
		for ((i=0;i<${#TEMPS[@]};++i)); do
			color="30;1;46m"
				
			if [[ "${TEMPS[i]}" -ge 60 && "${TEMPS[i]}" -lt "$maxCpuTemp" ]]; then
				color="38;5;0;1;48;5;127m"
			elif [[ "${TEMPS[i]}" -ge "$maxCpuTemp" ]]; then
				color="30;1;41m"
			fi
	
	    	printf "  Core %s: \e[${color} %s \e[0m" "${CORES[i]}" "${TEMPS[i]}"
		done
	fi
			
	if [ -n "$gpuTemp" ]; then
		color="30;1;46m"					
		if [[ "$gpuTemp" -ge 60 && "$gpuTemp" -lt "$maxGpuTemp" ]]; then
			color="38;5;0;1;48;5;127m"
		elif [[ "$gpuTemp" -ge "$maxGpuTemp" ]]; then
			color="30;1;41m"
		fi
		printf "  GPU: \e[${color} %s \e[0m" "$gpuTemp"
	fi

if [ -n "$miscTemp" ]; then
		color="30;1;46m"					
		if [[ "$miscTemp" -ge 60 && "$miscTemp" -lt "$maxCpuTemp" ]]; then
			color="38;5;0;1;48;5;127m"
		elif [[ "$miscTemp" -ge "$maxCpuTemp" ]]; then
			color="30;1;41m"
		fi
		printf "  Thermal: \e[${color} %s \e[0m" "$miscTemp"
	fi

	echo
	echo 
fi
