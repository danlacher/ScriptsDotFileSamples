#!/bin/ksh

function usage
{
	echo "usage: $0 [X] Y"
	echo "       where X is start of count"
	echo "       where Y is end of inclusive count"
	exit
}

if (( $# < 1 )) ; then
	usage
elif (( $# == 1 )) ; then
	BEGIN=0
	END=$1
elif [ $# > 1 ]; then
	BEGIN=$1
	END=$2
fi

CURRENT=$BEGIN

if (( $BEGIN > $END )); then 
	while (( $CURRENT >= $END )); do
		echo $CURRENT
		(( CURRENT=$CURRENT-1 ))
	done
else
	while (( $CURRENT <= $END )); do
		echo $CURRENT
		(( CURRENT=$CURRENT+1 ))
	done
fi
