#!/bin/bash
# This script toggle SW_ST LED near bracket
#

file=/run/media/mmcblk0p1/test-log/board.log-2020-4-15.17-43-42.log
query="test\ fail"

path=/sys/class/gpio
gpio=383
echo $gpio > $path/unexport
echo $gpio > $path/export
echo out > $path/gpio$gpio/direction
for i in {1..200};
do
	fail_cnt="$(cat $file | grep -o "$query" | wc -l)"
	echo $fail_cnt
	if [ $fail_cnt -lt 1 ]
	then
		echo "test fail count is $fail_cnt";
		echo "toggle the SW_ST LED light"
		echo 1 > $path/gpio$gpio/value
		sleep 1; 
		echo "toggle the SW_ST LED off"
		echo 0 > $path/gpio$gpio/value
		sleep 1; 

	else
		echo 0 > $path/gpio$gpio/value
		echo "burn-in test fail"
		break
	fi
done
	echo $gpio > $path/unexport
