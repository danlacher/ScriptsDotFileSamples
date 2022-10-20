#!/bin/ksh

########################################################################
# logrotate num_copies logfile {logfile}
#
# logrotate  - script name
# num_copies - number of back log files kept
# logfile    - log file to rotate
# {logfile}  - 0 or more logfiles
#
# This script will rotate 1 or more log files with a specified number of 
#  back logs.  The script will remove the oldest file, move all the others
#  up one step, mv the current to a tmp file, touch the new one, gzip up
#  the most recent and remove the tmp file.
########################################################################
 
PATH=/usr/bin

if (( $# < 2 ))
  then
    print "USAGE: logrotate num_copies logfile {logfile}"
    exit 1
fi

BACKLOG=$1		# number of back logs to keep
COUNT=
OLD=
NEW=

(( COUNT=$#-1 ))	# number of logs to rotate

shift			# moves the first log name into $1

while (( COUNT > 0 ))
  do
    OLD=$BACKLOG
    (( NEW=$OLD-1 ))
 
    LOG=$1
    shift		# moves the next log name into $1

    if [[ -a $LOG.$BACKLOG.gz ]] || [[ -f $LOG.$BACKLOG.gz ]] || [[ -r $LOG.$BACKLOG.gz ]]
      then
        rm -f $LOG.$BACKLOG.gz
    fi

    while (( OLD > 1 ))
      do
        if [[ -a $LOG.$NEW.gz ]] || [[ -f $LOG.$NEW.gz ]] || [[ -r $LOG.$NEW.gz ]]
          then
            mv $LOG.$NEW.gz $LOG.$OLD.gz
        fi
        OLD=$NEW
        (( NEW=$NEW-1 ))
    done
 
    mv $LOG $LOG.1
    touch $LOG

    gzip -9 $LOG.1

    (( COUNT=$COUNT-1 ))
  done
