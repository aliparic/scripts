#!/bin/sh
#i=0
#base=1
today=`date +%Y%m%d-%H%M%S`
touch  /monroe/ssout/ss$today.txt
secs=60
endTime=$(( $(date +%s) + secs ))
while [ $(date +%s) -lt $endTime ]
do
    echo `date +%s%3N` >>/monroe/ssout/ss$today.txt
    ssOut=`ss -ait | grep -A1 '130.243.27.222:amanda' | grep -A1 -E 'ESTAB.*'`
    echo $ssOut >> /monroe/ssout/ss$today.txt
#    echo $ssout
    sleep 0.005
    clear
done
