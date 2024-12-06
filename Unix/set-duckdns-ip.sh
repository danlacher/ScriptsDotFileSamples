#!/bin/sh

# Script for setting Duck DNS hostname from the command line

#
# crontab example
# m h  dom mon dow   command
#15 * * * * /home/USER/bin/get-ip MYDOMAIN.duckdns.org /home/USER/Downloads
#

DDHOST=$1
DBPATH=$2
TOKEN="DUCK-DNS-ACCESS-TOKEN"

LAST=`cat ${DBPATH}/${DDHOST}`
CURRENT=`curl -s ipecho.net/plain`

if [ "${CURRENT}" = "" ] ; then
	CURRENT=${LAST}
fi

if [ "${LAST}" != "${CURRENT}" ] ; then
	cp ${DBPATH}/${DDHOST} ${DBPATH}/${DDHOST}.old
	echo $CURRENT > ${DBPATH}/${DDHOST}
	echo $CURRENT > ${DBPATH}/${DDHOST}.txt
	echo `curl -s "https://www.duckdns.org/update?domains=${DDHOST}&token=${TOKEN}&ip=${CURRENT}"`
fi
