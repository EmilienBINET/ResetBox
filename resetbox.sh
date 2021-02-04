#!/bin/bash

# Default values
true ${HS110_IP:=192.168.1.100}

# Check Internet
echo "Starting Internet check ..."
while true
do
   wget -q -o - http://google.com >/dev/null
   if [[ $? -eq 0 ]]; then
     echo $(date) was: online
   else
     echo $(date) was: OFFLINE, retry in 30 seconds
     sleep 30
     wget -q -o - http://google.com >/dev/null
     if [[ $? -eq 0 ]]; then
       echo $(date) was: now online
     else
       echo $(date) was: still OFFLINE, reboot in 10s
       sleep 10
       tplink_smartplug.py -t ${HS110_IP} -c off
       sleep 3
       tplink_smartplug.py -t ${HS110_IP} -c on
       sleep 600
     fi
   fi
 sleep 300
done
