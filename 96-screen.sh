#! /bin/bash

# Prints list of running screen sessions
#

# Put a green or red dot in front depending on whether attached or detatched

if [[ $(which screen 2> /dev/null) ]]; then
	if [[ "$(screen -list | wc -l)" > 2 ]]; then
		sessions=$(screen -list | grep tached | tr -d '()' | column -t)
		detached=$(echo "$sessions" | grep "Detached" | sed 's/Detached//g')
		attached=$(echo "$sessions" | grep "Attached" | sed 's/Attached//g')
		printf "  Screen sessions:\n"   
        if [[ -n "$detached" ]]; then
            dot="\e[38;5;36m  ●\e[0m"
            while IFS= read -r line; do
                printf "$dot \e[0;37m$line\e[0m\n"
            done <<< "$detached"
        fi
        if [[ -n "$attached" ]]; then
        	dot="\e[38;5;198m  ●\e[0m"     
            while IFS= read -r line; do
                printf "$dot \e[0;37m$line\e[0m\n"
            done <<< "$attached"
        fi
        echo ""
    fi
fi
