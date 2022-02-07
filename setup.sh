#!/bin/bash
if ["adb start-server"="-bash: adb: command not found"]
echo "Enter IP address of the watch:"
read watch_IP
watch_IP="$watch_IP:5555"
echo here
echo adb connect $watch_IP
# while == "failed to authenticate to $watch_IP"
stop=0
while [ 0 == $stop ]
do
    if [ "adb connect $watch_IP"="already connected to $watch_IP" ]; then
        echo "Connected to watch"
        stop=1
    else
        adb connect $watch_IP 
        echo "Please accept prompt on watch"
        sleep 1
    fi
done
