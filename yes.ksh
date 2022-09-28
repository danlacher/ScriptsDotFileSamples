#!/bin/ksh

if (( $# < 1 ))
  then
    YES="y"
else
    YES=$1
fi

while (( 1 ))
  do
    echo $YES
  done
