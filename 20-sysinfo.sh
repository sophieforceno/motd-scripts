#! /bin/bash

# System information (uptime, load, # processes, # logged in users) for MOTD
#

source $HOME/.config/motd.conf

uptime=$(uptime -p)
ip=$(curl -s "https://api.ipify.org?format=text")

users=( $(who | awk '{ print $1 }' | uniq) )
process=$(ps ax | wc -l)
load=$(uptime | awk -F : '{ print $5 }')

# From: https://gist.githubusercontent.com/joemiller/4069513/raw/dfde5a68e8ab4ac114e89156180bc93debb05993/netspeed.sh
r1=$(cat /sys/class/net/$iface/statistics/rx_bytes)
t1=$(cat /sys/class/net/$iface/statistics/tx_bytes)
# In my informal testing, I found 0.5 as accurate as 1.0 
# when comparing both to htop's output, but ymmv
sleep 0.5
r2=$(cat /sys/class/net/$iface/statistics/rx_bytes)
t2=$(cat /sys/class/net/$iface/statistics/tx_bytes)
tbps=$(expr $t2 - $t1)
rpbs=$(expr $r2 - $r1)
tkbps=$(expr $tbps / 1024)
rkbps=$(expr $rpbs / 1024)

echo -e "  Uptime: \e[0;37m$uptime\e[0m"
echo -e "  Load: \e[0;37m$load\e[0m"
echo -e "  Processes: \e[0;37m$process\e[0m"
echo
echo -e "  External IP: \e[0;37m$ip\e[0m"
echo -e "  Network: Tx: \e[0;37m$tkbps kbps\e[0m, Rx: \e[0;37m$rkbps kbps\e[0m"
echo -e "  Users: \e[0;37m${users[@]}\e[0m"
echo