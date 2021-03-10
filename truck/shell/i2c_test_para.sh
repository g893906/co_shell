#!/bin/bash
# This script toggle SW_ST LED near bracket
#

i2cset="i2cset -f -y 1"
i2cget="i2cget -f -y 1"
i2cget_voltage_value="i2cget -f -y 1 0x34 0x8b w"
slave_addr=0x34
page_addr=0x00
exponent_addr=0x20
data_addr=0x8b

for j in {0..9}
do
  for i in {0..9}
  do
     $i2cset $slave_addr $page_addr $i
     echo "The rail $i exponent decimal is"
     $i2cget $slave_addr $exponent_addr
     echo "The rali $i voltage value is"
     $i2cget_voltage_value
  done
done
