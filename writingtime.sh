#!/bin/bash

off_time=${1}

start_date=`date`
end_date=`date -d "${1} minutes"`
target_epoch=$(date -d "${1} minutes" +%s)

trap catched INT
trap cleanup TERM EXIT

catched(){
    echo
    echo "Do not kill me, internet is coming back at ${end_date}".
    trap '' INT
    sleep $(( ${target_epoch} - $(date +%s)  ))
}

cleanup(){
    n-m activate 802-11-wireless
    n-m activate 802-3-ethernet
    echo
    echo "It is ${end_date} you were off for ${off_time} minutes"
    echo "It is ${end_date} you were off for ${off_time} minutes" >> ~/offtime.txt
}


echo "It is ${start_date} you are going off for ${off_time} minutes"
echo "It is ${start_date} you are going off for ${off_time} minutes" >> ~/offtime.txt


n-m offline
sleep $(( ${target_epoch} - $(date +%s)  ))

