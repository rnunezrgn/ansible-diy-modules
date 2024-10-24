#!/bin/bash
# The module checks for system uptime of the target machine. The module takes in 'detailed' bool argument from the user
# It returns a JSON output since an Ansible module should output a Valid JSON.

source $1

if [ -f "/proc/uptime" ]; then
    uptime=`cat /proc/uptime`
    uptime=${uptime%%.*}
    days=$(( uptime/60/60/24 ))
    hours=$(( uptime/60/60%24 ))
    if [ $detailed ]; then
        minutes=$(( uptime/60%60 ))
        seconds=$(( uptime%60 ))
        uptime="$days days, $hours hours, $minutes minutes, $seconds seconds"
    else
        uptime="$days days, $hours hours"
    fi
else
    uptime=""
fi

echo -e "{\"uptime\":\""$uptime"\"}"
