#!/bin/bash

# Default values
true ${HS110_IP:=192.168.1.100}
true ${URL:=http://google.com}
true ${D1:=300}
true ${D2:=30}
true ${D3:=10}
true ${D4:=3}
true ${D5:=600}

# Check Internet
echo "Starting Internet check ..."
while true
do
   wget -q --spider ${URL}
   if [[ $? -eq 0 ]]; then
     echo $(date) was: online
   else
     echo $(date) was: OFFLINE, retry in ${D2} seconds
     sleep ${D2}
     wget -q --spider ${URL}
     if [[ $? -eq 0 ]]; then
       echo $(date) was: now online
     else
       echo $(date) was: still OFFLINE, reboot in ${D3} seconds
       sleep ${D3}
       tplink_smartplug.py -t ${HS110_IP} -c off
       sleep ${D4}
       tplink_smartplug.py -t ${HS110_IP} -c on
       sleep ${D5}
     fi
   fi
 echo -n $(date) SmartPlug test :
 tplink_smartplug.py -q -t ${HS110_IP} -c info
 sleep ${D1}
done
echo "Stopped Internet check ..."
