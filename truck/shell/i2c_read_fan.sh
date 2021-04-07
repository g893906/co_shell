#!/bin/bash
#This script is used for LEDA-S FAN board ADT7476 controller

i2cset_fan_ctrl="i2cset -f -y 1 0x2e" #ADT7476 slave address is 0x23
i2cget_fan_ctrl="i2cget -f -y 1 0x2e"
GPIO_mux="0x7C"     #bit[4] set the VID as GPO function
GPIO_set="0x43"     #bit[0] is relay: 1 active, bit[1] is alarm led: 0 active, bit[2] is sys led: 0 active
PWM1_manual="0x5c" #bit[7:5] set as 111 for manual mode
PWM2_manual="0x5d" #bit[7:5] set as 111 for manual mode
PWM3_manual="0x5e" #bit[7:5] set as 111 for manual mode
PWM1_min="0x64"     #set the PWM1 min value
PWM2_min="0x65"     #set the PWM2 min value  
PWM3_min="0x66"     #set the PWM3 min value
PWM1_max="0x38"     #set the PWM1 max value      
PWM2_max="0x39"     #set the PWM2 max value
PWM3_max="0x3a"     #set the PWM3 max value
PWM_FPWM="0x61"     #bit[3] set the PWM freq. 22.5Khz, fan spec. requires the min PWM freq is 22Khz
PWM_STRT="0x40"     #bit[0] STRT must set as 1, then the PWM1_val/PWM2_val/PWM3_val could be applied to fan speed
PWM1_val="0x30"     #set the PWM1 value     
PWM2_val="0x31"     #set the PWM2 value
PWM3_val="0x32"     #set the PWM3 value
min="0x00"
max="0xff"
mid="0x7f"
TACH_N_cnt="0x7B"   #bit[1:0] for set the FAN1 TACH pluses to be counted
FAN_TACH1_L="0x28"  #read the fan1 tach low byte value, the 4028 FAN pulses counted is 2. 
FAN_TACH1_H="0x29"  #read the fan1 tach high byte value
FAN_TACH2_L="0x2a"  #read the fan2 tach low byte value
FAN_TACH2_H="0x2b"  #read the fan2 tach high byte value
FAN_TACH3_L="0x2c"  #read the fan3 tach low byte value
FAN_TACH3_H="0x2d"  #read the fan3 tach high byte value
OSC_CLK="90000"
min_sec="60"        #fan speed=(OSC_CLK*min_sec)/(tach_dec) RPM


val=$($i2cget_fan_ctrl $GPIO_mux)
val=$(($val | 0x10))
$i2cset_fan_ctrl $GPIO_mux $val
val=$($i2cget_fan_ctrl $GPIO_mux)
echo "GPIO_mux read value, $val"

val=$($i2cget_fan_ctrl $GPIO_set)
val=$(($val & 0xf8))
$i2cset_fan_ctrl $GPIO_set $val
val=$($i2cget_fan_ctrl $GPIO_set)
echo "GPIO_set read value, $val"


val=$($i2cget_fan_ctrl $PWM3_manual)
val=$(($val | 0xe0))
$i2cset_fan_ctrl $PWM3_manual $val
val=$($i2cget_fan_ctrl $PWM3_manual)
echo "PWM3_manual read value, $val"

val=$($i2cget_fan_ctrl $PWM1_manual)
val=$(($val | 0xe0))
$i2cset_fan_ctrl $PWM1_manual $val
val=$($i2cget_fan_ctrl $PWM1_manual)
echo "PWM1_manual read value, $val"

val=$($i2cget_fan_ctrl $PWM2_manual)
val=$(($val | 0xe0))
$i2cset_fan_ctrl $PWM2_manual $val
val=$($i2cget_fan_ctrl $PWM2_manual)
echo "PWM2_manual read value, $val"

val=$($i2cget_fan_ctrl $PWM_STRT)
val=$(($val | 0x01))
$i2cset_fan_ctrl $PWM_STRT $val
val=$($i2cget_fan_ctrl $PWM_STRT)
echo "PWM_STRT read value, $val"

$i2cset_fan_ctrl $PWM3_min $min
$i2cset_fan_ctrl $PWM3_max $max
$i2cset_fan_ctrl $PWM2_min $min
$i2cset_fan_ctrl $PWM2_min $min
$i2cset_fan_ctrl $PWM1_max $max
$i2cset_fan_ctrl $PWM1_max $max

val=$($i2cget_fan_ctrl $PWM_FPWM)
val=$(($val | 0x08))
$i2cset_fan_ctrl $PWM_FPWM $val
val=$($i2cget_fan_ctrl $PWM_FPWM)
echo "PWM_FPWM read value, $val"

$i2cset_fan_ctrl $PWM3_val $mid


echo "Fan #, tach low byte, tach high byte, dec value"
for j in {0..1000}
do
    low_byte=$($i2cget_fan_ctrl $FAN_TACH3_L)
    high_byte=$($i2cget_fan_ctrl $FAN_TACH3_H)
    #echo "low_byte,$low_byte"
    #echo "high_byte,$high_byte"
    low_byte=$(($low_byte))
    high_byte=($(($high_byte)))
    high_byte=`expr $high_byte \* 256`
    #echo "low_byte,$low_byte"
    #echo "high_byte,$high_byte"
    tach3_val=`expr $high_byte \+ $low_byte`
    fan3_speed=`expr $OSC_CLK \* $min_sec / $tach3_val`
    #echo "tach3_val,$tach3_val"
    echo "fan3_speed RPM,$FAN_TACH3_L, $FAN_TACH3_H, $fan3_speed"
    sleep 2
done

