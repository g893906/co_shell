#!/bin/bash
# This script toggle SW_ST LED near bracket
#
helpFunction()
{
   echo ""
   echo "Usage: $0 -p parameterB -n parameterC"
   echo -e "\t-p Description of what power rail want to monitor"
   echo -e "\t-n Description of how many loops you want to run"
   exit 1 # Exit script after printing help
}

while getopts "p:n:" opt
do
   case "$opt" in
      p ) power_rail="$OPTARG" ;;
      n ) loop_cnt="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$power_rail" ] || [ -z "$loop_cnt" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

i2cset="i2cset -f -y 1"
i2cget="i2cget -f -y 1"
i2cget_voltage_value="i2cget -f -y 1 0x34 0x8b w"
i2cget_current_value="i2cget -f -y 1 0x34 0x8c w"
slave_addr=0x34
page_addr=0x00
exponent_addr=0x20
data_addr=0x8b
echo "The rail $power exponent decimal is"
for j in {0..9}
do
    echo "=============================="
    echo "The power rail is $j"
    echo "voltage hex value for ten times"
    echo "time delay is 1 sec between each read"
    echo "=============================="
    $i2cset $slave_addr $page_addr $j
    echo "exponent value="
    $i2cget $slave_addr $exponent_addr
    for ((i=0;i<$loop_cnt;i++))
    do
        $i2cget_voltage_value
        sleep 1
    done
done

echo "=============================="
echo "current hex value for ten times"
echo "time delay is 1 sec between each read"
echo "the current format is linear11, total hex is 16bit, MSB 5bit is 2's complement. "
echo "11bits*2^(-?)="
echo "=============================="
$i2cset $slave_addr $page_addr 0
echo "exponent value="
for ((i=0;i<$loop_cnt;i++))
do
    $i2cget_current_value
    sleep 1
done

