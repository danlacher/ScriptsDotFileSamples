#!/bin/bash

for (( i=0; i>=0; i++ ))
do
	echo $i
	DISPLAY=:0.0 XAUTHORITY=/home/pi/.Xauthority \
	timeout 45 \
		chromium-browser \
			--temp-profile \
			--start-fullscreen \
			/home/pi/Downloads/full-screen-clock-12hr-with-seconds.html \
			> /dev/null 2>&1
	DISPLAY=:0.0 XAUTHORITY=/home/pi/.Xauthority \
	timeout 570s \
		/usr/bin/feh \
			--auto-zoom \
			--borderless \
			--fullscreen \
			--hide-pointer \
			--randomize \
			--recursive \
			--slideshow-delay 5.0 \
			/home/pi/images \
			> /dev/null 2>&1
			#--reload 60 \
	sudo sh -c "sync ; echo 3 > /proc/sys/vm/drop_caches"

	rm -rf /tmp/tmp.*
	rm -rf /tmp/.org.chromium.Chromium.*

done

# https://www.nayuki.io/res/full-screen-clock-javascript/full-screen-clock-12hr-with-seconds.html
# kill -9 $(ps -ef | egrep -i "feh|timeout|slide" | grep -v grep | awk -F" " '{print $2}')
# while(1>0); do slide.sh; done