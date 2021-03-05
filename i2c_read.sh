#!/bin/bash
#This script is used for Artesyn power brick that implemented in LEDA-E proto4-2 board

i2cget="i2cget -f -y 1"
master="0x42"
slave="0x41"
freq="0x33 w"
sta_byte="0x78"
sta_wd="0x79 w"
sta_vout="0x7a"
sta_iout="0x7b"
sta_in="0x7c"
sta_temp="0x7e"
read_vin="0x88 w"
read_vout="0x8b w"
read_iout="0x8c w"
read_temp="0x8f w"
read_freq="0x95 w"

for j in {0..1000}
do
    echo "read the master $master freq_set, status byte/word/vout/iout/vin/temp, read vin/vout/iout/temp/freq \n"
    $i2cget $master $freq
    $i2cget $master $sta_byte
    $i2cget $master $sta_wd
    $i2cget $master $sta_vout
    $i2cget $master $sta_iout
    $i2cget $master $sta_in
    $i2cget $master $sta_temp
    $i2cget $master $read_vin
    $i2cget $master $read_vout
    $i2cget $master $read_iout
    $i2cget $master $read_temp
    $i2cget $master $read_freq
	sleep 2
    echo "read the slave $slave freq_set, status byte/word/vout/iout/vin/temp, read vin/vout/iout/temp/freq \n"
    $i2cget $slave $freq
    $i2cget $slave $sta_byte
    $i2cget $slave $sta_wd
    $i2cget $slave $sta_vout
    $i2cget $slave $sta_iout
    $i2cget $slave $sta_in
    $i2cget $slave $sta_temp
    $i2cget $slave $read_vin
    $i2cget $slave $read_vout
    $i2cget $slave $read_iout
    $i2cget $slave $read_temp
    $i2cget $slave $read_freq
	sleep 2
done

