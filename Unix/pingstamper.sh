#!/bin/sh

function usage
{
	echo "usage: $0 [X] Y"
	echo "       where X is server to ping"
	echo "       where Y is time between pings, default is 1 sec"
	exit
}

if (( $# < 1 )) ; then
	usage
elif (( $# == 1 )) ; then
	SVR=$1
	TIME=1
elif [ $# > 1 ]; then
	SVR=$1
	TIME=$2
fi

while (( $TIME >= 0 )); do
	echo "`date` : `ping -c 1 ${SVR} | grep ^64`"
	sleep $TIME
done
