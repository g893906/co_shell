#!/bin/bash

i2cget="i2cget -f -y 1"
i2cget_42_iout="i2cget -f -y 1 0x42 0x8c w"
i2cget_42_vout="i2cget -f -y 1 0x42 0x8b w"
i2cget_42_temp="i2cget -f -y 1 0x42 0x8f w"
i2cget_42_sta="i2cget -f -y 1 0x42 0x79 w"
i2cget_55_iout="i2cget -f -y 1 0x55 0x8c w"
i2cget_55_temp="i2cget -f -y 1 0x55 0x8f w"
i2cget_55_sta="i2cget -f -y 1 0x55 0x79 w"
i2cget_55_vout="i2cget -f -y 1 0x55 0x8b w"
echo "To record the 0x42 and 0x55 iout value"
for j in {0..1000}
do
	echo "read the 0x42 iout" 
    $i2cget_42_iout
	echo "read the 0x42 temp" 
    $i2cget_42_temp
	echo "read the 0x42 status" 
    $i2cget_42_sta
	echo "read the 0x42 vout" 
    $i2cget_42_vout
	sleep 2
	echo "read the 0x55 iout" 
    $i2cget_55_iout
	echo "read the 0x55 temp" 
    $i2cget_55_temp
	echo "read the 0x55 status"	
    $i2cget_55_sta
	echo "read the 0x55 vout" 
    $i2cget_55_vout
	sleep 2
done

