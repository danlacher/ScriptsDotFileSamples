#!/bin/bash

# I don't recall if wrote this script myself or a version of something Jeff Geerling (@geerlingguy) showed
#
# Simple script to display temp and freq data from cores on a Raspberry Pi

#vcgencmd get_config int
Counter=69
DisplayHeader="Time       Temp     CPU     Core          Health          Vcore"

while true ; do
    let ++Counter
    if [ ${Counter} -ge 69 ]; then
        echo -e "${DisplayHeader}"
        Counter=0
    fi

    Health=$(perl -e "printf \"%19b\n\", $(vcgencmd get_throttled | cut -f2 -d=)")
    TempC=$(vcgencmd measure_temp | cut -f2 -d=)
    TempF=$(vcgencmd measure_temp | awk -F "[=\']" '{print($2 * 1.8)+32}')
	Clockspeed=$(vcgencmd measure_clock arm | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
	Corespeed=$(vcgencmd measure_clock core | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
	CoreVolt=$(vcgencmd measure_volts | cut -f2 -d= | sed 's/000//')
	#echo -e "${TempC} ${TempF}"
	echo -e "$(date '+%H:%M:%S')  ${TempC}  $(printf '%4s' ${Clockspeed})MHz $(printf '%4s' ${Corespeed})MHz  $(printf '%020u' ${Health})  ${CoreVolt}"
	sleep 5
done