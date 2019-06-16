#! /bin/bash

# System information (uptime, load, # processes, # logged in users) for MOTD
#

source $HOME/.config/motd.conf

uptime=$(uptime -p)
ip=$(curl -s ifconfig.co)
users=( $(who | awk '{ print $1 }' | uniq) )
process=$(ps ax | wc -l)
#bandwidth=$(sar -n DEV 1 3 | grep 'eth0' | tail -n1 | awk '{ print $5 $6}')
load=$(uptime | awk -F : '{ print $5 }')

# From: https://gist.githubusercontent.com/joemiller/4069513/raw/dfde5a68e8ab4ac114e89156180bc93debb05993/netspeed.sh
#
R1=`cat /sys/class/net/$iface/statistics/rx_bytes`
T1=`cat /sys/class/net/$iface/statistics/tx_bytes`
sleep 0.5
R2=`cat /sys/class/net/$iface/statistics/rx_bytes`
T2=`cat /sys/class/net/$iface/statistics/tx_bytes`
TBPS=`expr $T2 - $T1`
RBPS=`expr $R2 - $R1`
TKBPS=`expr $TBPS / 1024`
RKBPS=`expr $RBPS / 1024`

echo -e "  Uptime: \e[0;37m$uptime\e[0m"
echo -e "  Load: \e[0;37m$load\e[0m"
echo -e "  Processes: \e[0;37m$process\e[0m"
echo
echo -e "  External IP: \e[0;37m$ip\e[0m"
echo -e "  Network: Tx: \e[0;37m$TKBPS kbps\e[0m, Rx: \e[0;37m$RKBPS kbps\e[0m"
echo -e "  Users: \e[0;37m${users[@]}\e[0m"
echo