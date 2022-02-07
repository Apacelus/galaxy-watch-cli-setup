#!/bin/bash
if [ "adb start-server"="-bash: adb: command not found" ]; then
    echo "Please install adb first."
fi
echo "Enter IP address of the watch:"
read watch_IP
watch_IP="$watch_IP:5555"
# while == "failed to authenticate to $watch_IP"
stop=0
# Connecting to watch
while [ 0 == $stop ]
do
    if [ "adb connect $watch_IP"="already connected to $watch_IP" ]
    then
        echo "Connected to watch"
        stop=1
    else
        adb connect $watch_IP
        echo "Please accept prompt on watch"
        sleep 1
    fi
done
# Bloat removal part
if [ "$1" = "--remove-bloat" ]; then
    echo "Removing Samsung pay, bixby and worldclock"
    adb shell pm uninstall -k --user 0 com.samsung.android.bixby.agent
    adb shell pm uninstall -k --user 0 com.samsung.android.samsungpay.gear
    adb shell pm uninstall -k --user 0 com.samsung.android.bixby.wakeup
    adb shell pm uninstall -k --user 0 com.samsung.android.watch.worldclock
elif [ "$1" = "--keep-bloat" ]; then
    echo "Keeping bloat"
fi
# SHM install part
if [ "$2" = "--replace-shm" ]; then
    echo "Removing stock SHM"
    adb shell pm uninstall -k --user 0 com.samsung.android.shealthmonitor
    adb install curl "https://drive.google.com/file/d/1EgM6DmqceKMhWQuLurQZq75Xvu1GA123/view?usp=sharing"
    echo "Installed SHM successfully" 
elif [ "$2" = "--keep-shm" ]; then
    adb install curl "https://drive.google.com/file/d/1EgM6DmqceKMhWQuLurQZq75Xvu1GA123/view?usp=sharing"
    echo "Installed SHM successfully"
fi
# Installing dnd-sync
if [ "$3" = "--install-dnd-sync" ]; then
    adb install curl "https://github.com/rhaeus/dnd-sync/releases/download/v1.0/dndsync_mobile.apk"
    echo "Dnd-sync v1.0 installed successfully"
elif [ "$3" = "--skip-dnd-sync" ]; then
    echo "Not installing dnd-sync"
fi
