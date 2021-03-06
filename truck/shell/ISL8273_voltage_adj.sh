#!/bin/bash
#This script is used for Renesas ISL8273M Vout adjustment

helpFunction()
{
    echo ""
    echo "Usage: $0 -v parameterB -n parameterC"
    echo -e "\t-v Description of what voltage you want to set: 1 for 0.95v, 2 for 1v, 3 for 1.05v are available"
    echo -e "\t-n Description how many count you want to monitor the voltage"
    echo -e "\t-m Description of the margin high or low for 4-corners testing: 1 for low margin, 2 for high margin, 3 for normal"
    exit 1 # Exit script after printing help
}

while getopts "v:n:m:" opt
do
    case "$opt" in
        v ) target_v="$OPTARG";;
        n ) mon_n="$OPTARG";;
        m ) margin="$OPTARG";;
        ? ) helpfunction;; #Print helpFunction in case parameter is non-existent
    esac
done

# Print helpFunction in case parameter are empty
if [ -z $mon_n ] || [ -z $target_v ] || [ $margin -lt 1 ] || [ $margin -gt 3 ]
then
    echo "Some or all the parameters are empty";
    helpFunction
fi

echo "Totalargument: $#"
echo "target voltage is: $target"
echo "voltage monitor count: $mon_n"
echo "margin select: $margin"

i2cset_8273_a="i2cset -f -y 1 0x19"
i2cget_8273_a="i2cget -f -y 1 0x19"
i2cset_8273_b="i2cset -f -y 1 0x1a"
i2cget_8273_b="i2cget -f -y 1 0x1a"
i2cset_9090="i2cset -f -y 1 0x34"
i2cget_9090="i2cget -f -y 1 0x34"
i2cset_549D22="i2cset -f -y 1 0x14"
i2cget_549D22="i2cget -f -y 1 0x14"
i2cset_549B22="i2cset -f -y 1 0x10"
i2cget_549B22="i2cget -f -y 1 0x10"
r_9090_page="0x00"
r_9090_APU_rail="5"
r_9090_vout_mode="0x20"
r_margin="0x01"
r_margin_h="0x25"
r_margin_l="0x26"
r_sta="0x7a"
r_vset="0x21"
r_ovp="0x40"
r_ovw="0x42"
r_uvp="0x44"
r_uvw="0x43"
r_ov_max="0x24"
r_save_user="0x15"
r_current="0x8c"
r_temp_e="0x8e"
r_temp_i="0x8d"
r_vout="0x8b"
#margin setting
hex_margin_h="0xa4"
hex_margin_l="0x94"
hex_margin_n="0x84"
hex_549B22_margin_l="0x0248"
hex_549D22_margin_l="0x019d"
hex_549D22_margin_h="0x01c9"
#============set the VDD1V2 h/l margin (FPGA/APU TPS549B22)===============#
$i2cset_549B22 $r_margin_l $hex_549B22_margin_l w #1.14, the high voltage could only 1.2V by command
#============set the VDD0V85 h/l margin (FPGA TPS549D22)===============#
$i2cset_549D22 $r_margin_h $hex_549D22_margin_h w #0.8925
$i2cset_549D22 $r_margin_l $hex_549D22_margin_l w #0.8075
#============set the VDD0V95 h/l margin (APU RENESAS)===============#


if [ $margin -eq 1 ]
then
    $i2cset_9090 $r_9090_page 0x01
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_l
    echo "set VDD1V8 as low margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x02
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_l
    echo "set VDD2V5 as low margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x07
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_l
    echo "set VDD0V9_MGT as low margin, $($i2cget_9090 $r_margin) "
    $i2cset_549B22 $r_margin $hex_margin_l
    echo "set VDD0V85 as low margin, $($i2cget_549B22 $r_margin) "
    $i2cset_549D22 $r_margin $hex_margin_l
    echo "set VDD1V2 as low margin, $($i2cget_549D22 $r_margin)"

elif [ $margin -eq 2 ]
then
    $i2cset_9090 $r_9090_page 0x01
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_h
    echo "set VDD1V8 as high margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x02
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_h
    echo "set VDD2V5 as high margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x07
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_h
    echo "set VDD0V9_MGT as high margin, $($i2cget_9090 $r_margin) "
    $i2cset_549B22 $r_margin $hex_margin_h
    echo "set VDD0V85 as high margin, $($i2cget_549B22 $r_margin) "
    $i2cset_549D22 $r_margin $hex_margin_h
    echo "set VDD1V2 as high margin, $($i2cget_549D22 $r_margin)"
elif [ $margin -eq 3 ]
then
    $i2cset_9090 $r_9090_page 0x01
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_n
    echo "set VDD1V8 as normal margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x02
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_n
    echo "set VDD2V5 as normal margin, $($i2cget_9090 $r_margin) "
    $i2cset_9090 $r_9090_page 0x07
    sleep 0.5
    $i2cset_9090 $r_margin $hex_margin_n
    echo "set VDD0V9_MGT as normal margin, $($i2cget_9090 $r_margin) "
    $i2cset_549B22 $r_margin $hex_margin_n
    echo "set VDD0V85 as normal margin, $($i2cget_549B22 $r_margin) "
    $i2cset_549D22 $r_margin $hex_margin_n
    echo "set VDD1V2 as normal margin, $($i2cget_549D22 $r_margin)"
fi

# 0.95 related setting
hex_0v95="0x1e66"
hex_0v95_ovp="0x22f5"
hex_0v95_ovw="0x2170"
hex_0v95_uvp="0x19d7"
hex_0v95_uvw="0x1b5c"
hex_0v95_max="0x2170"
# 1.0 related setting
hex_1v0="0x2000"
hex_1v0_ovp="0x24cc"
hex_1v0_ovw="0x2333"
hex_1v0_uvp="0x1b33"
hex_1v0_uvw="0x1ccc"
hex_1v0_max="0x2333"
# 1.05 related setting
hex_1v05="0x2199"
hex_1v05_ovp="0x26a3"
hex_1v05_ovw="0x24f5"
hex_1v05_uvp="0x1c8f"
hex_1v05_uvw="0x1e3d"
hex_1v05_max="0x24f5"

re_9090_ovp=$($i2cget_9090 $r_ovp w)  
re_9090_ovw=$($i2cget_9090 $r_ovw w)
re_9090_uvp=$($i2cget_9090 $r_uvp w)
re_9090_uvw=$($i2cget_9090 $r_uvw w)
echo " ===setting value, vset, ovp, ovw, uvp, uvw, ov_max ===="
echo "============================="
if [ $target_v -eq 1 ]
then
    echo "target vout is 0.95, ovp is 0.95*1.15, ovw is 0.95*1.1, uvp is 0.95*0.85, uvw is 0.95*0.9, vout_max is 0.95*1.1"
    $i2cset_8273_a $r_vset $hex_0v95 w
    $i2cset_8273_a $r_ovp $hex_0v95_ovp w
    $i2cset_8273_a $r_ovw $hex_0v95_ovw w
    $i2cset_8273_a $r_uvp $hex_0v95_uvp w
    $i2cset_8273_a $r_uvw $hex_0v95_uvw w
    $i2cset_8273_a $r_ov_max $hex_0v95_max w
    $i2cset_8273_a $r_save_user
    $i2cset_8273_b $r_vset $hex_0v95 w
    $i2cset_8273_b $r_ovp $hex_0v95_ovp w
    $i2cset_8273_b $r_ovw $hex_0v95_ovw w
    $i2cset_8273_b $r_uvp $hex_0v95_uvp w
    $i2cset_8273_b $r_uvw $hex_0v95_uvw w
    $i2cset_8273_b $r_ov_max $hex_0v95_max w
    $i2cset_8273_b $r_save_user
    sleep 1
    re_a_vset=$($i2cget_8273_a $r_vset w)
    re_a_ovp=$($i2cget_8273_a $r_ovp w)  
    re_a_ovw=$($i2cget_8273_a $r_ovw w)
    re_a_uvp=$($i2cget_8273_a $r_uvp w)
    re_a_uvw=$($i2cget_8273_a $r_uvw w)
    re_a_ov_max=$($i2cget_8273_a $r_ov_max w)
    echo "a module vset, $re_a_vset, ovp, $re_a_ovp, ovw , $re_a_ovw , uvp , $re_a_uvp , uvw , $re_a_uvw , ov_max is  $re_a_ov_max"
    re_b_vset=$($i2cget_8273_b $r_vset w)
    re_b_ovp=$($i2cget_8273_b $r_ovp w)  
    re_b_ovw=$($i2cget_8273_b $r_ovw w)
    re_b_uvp=$($i2cget_8273_b $r_uvp w)
    re_b_uvw=$($i2cget_8273_b $r_uvw w)
    re_b_ov_max=$($i2cget_8273_b $r_ov_max w)
    echo "b module vset, $re_b_vset, ovp, $re_b_ovp, ovw , $re_b_ovw , uvp , $re_b_uvp , uvw , $re_b_uvw , ov_max is  $re_b_ov_max"
    echo "ucd9090 ovp, $re_9090_ovp, ovw , $re_9090_ovw , uvp , $re_9090_uvp , uvw , $re_9090_uvw"
elif [ $target_v -eq 2 ]
then
    echo "target vout is 1.0, ovp is 1.0*1.15, ovw is 1.0*1.1, uvp is 1.0*0.85, uvw is 1.0*0.9, vout_max is 1.0*1.1"
    $i2cset_8273_a $r_vset $hex_1v0 w
    $i2cset_8273_a $r_ovp $hex_1v0_ovp w
    $i2cset_8273_a $r_ovw $hex_1v0_ovw w
    $i2cset_8273_a $r_uvp $hex_1v0_uvp w
    $i2cset_8273_a $r_uvw $hex_1v0_uvw w
    $i2cset_8273_a $r_ov_max $hex_1v0_max w
    $i2cset_8273_a $r_save_user
    $i2cset_8273_b $r_vset $hex_1v0 w
    $i2cset_8273_b $r_ovp $hex_1v0_ovp w
    $i2cset_8273_b $r_ovw $hex_1v0_ovw w
    $i2cset_8273_b $r_uvp $hex_1v0_uvp w
    $i2cset_8273_b $r_uvw $hex_1v0_uvw w
    $i2cset_8273_b $r_ov_max $hex_1v0_max w
    $i2cset_8273_b $r_save_user
    sleep 1
    re_a_vset=$($i2cget_8273_a $r_vset w)
    re_a_ovp=$($i2cget_8273_a $r_ovp w)  
    re_a_ovw=$($i2cget_8273_a $r_ovw w)
    re_a_uvp=$($i2cget_8273_a $r_uvp w)
    re_a_uvw=$($i2cget_8273_a $r_uvw w)
    re_a_ov_max=$($i2cget_8273_a $r_ov_max w)
    echo "a module vset, $re_a_vset, ovp, $re_a_ovp, ovw , $re_a_ovw , uvp , $re_a_uvp , uvw , $re_a_uvw , ov_max is  $re_a_ov_max"
    re_b_vset=$($i2cget_8273_b $r_vset w)
    re_b_ovp=$($i2cget_8273_b $r_ovp w)  
    re_b_ovw=$($i2cget_8273_b $r_ovw w)
    re_b_uvp=$($i2cget_8273_b $r_uvp w)
    re_b_uvw=$($i2cget_8273_b $r_uvw w)
    re_b_ov_max=$($i2cget_8273_b $r_ov_max w)
    echo "b module vset, $re_b_vset, ovp, $re_b_ovp, ovw , $re_b_ovw , uvp , $re_b_uvp , uvw , $re_b_uvw , ov_max is  $re_b_ov_max"
    echo "ucd9090 ovp, $re_9090_ovp, ovw , $re_9090_ovw , uvp , $re_9090_uvp , uvw , $re_9090_uvw"
elif [ $target_v -eq 3 ]
then
    echo "target vout is 1.05, ovp is 1.05*1.15, ovw is 1.05*1.1, uvp is 1.05*0.85, uvw is 1.05*0.9, vout_max is 1.05*1.1"
    $i2cset_8273_a $r_vset $hex_1v05 w
    $i2cset_8273_a $r_ovp $hex_1v05_ovp w
    $i2cset_8273_a $r_ovw $hex_1v05_ovw w
    $i2cset_8273_a $r_uvp $hex_1v05_uvp w
    $i2cset_8273_a $r_uvw $hex_1v05_uvw w
    $i2cset_8273_a $r_ov_max $hex_1v05_max w
    $i2cset_8273_a $r_save_user
    $i2cset_8273_b $r_vset $hex_1v05 w
    $i2cset_8273_b $r_ovp $hex_1v05_ovp w
    $i2cset_8273_b $r_ovw $hex_1v05_ovw w
    $i2cset_8273_b $r_uvp $hex_1v05_uvp w
    $i2cset_8273_b $r_uvw $hex_1v05_uvw w
    $i2cset_8273_b $r_ov_max $hex_1v05_max w
    $i2cset_8273_b $r_save_user
    sleep 1
    re_a_vset=$($i2cget_8273_a $r_vset w)
    re_a_ovp=$($i2cget_8273_a $r_ovp w)  
    re_a_ovw=$($i2cget_8273_a $r_ovw w)
    re_a_uvp=$($i2cget_8273_a $r_uvp w)
    re_a_uvw=$($i2cget_8273_a $r_uvw w)
    re_a_ov_max=$($i2cget_8273_a $r_ov_max w)
    echo "a module vset, $re_a_vset, ovp, $re_a_ovp, ovw , $re_a_ovw , uvp , $re_a_uvp , uvw , $re_a_uvw , ov_max is  $re_a_ov_max"
    re_b_vset=$($i2cget_8273_b $r_vset w)
    re_b_ovp=$($i2cget_8273_b $r_ovp w)  
    re_b_ovw=$($i2cget_8273_b $r_ovw w)
    re_b_uvp=$($i2cget_8273_b $r_uvp w)
    re_b_uvw=$($i2cget_8273_b $r_uvw w)
    re_b_ov_max=$($i2cget_8273_b $r_ov_max w)
    echo "b module vset, $re_b_vset, ovp, $re_b_ovp, ovw , $re_b_ovw , uvp , $re_b_uvp , uvw , $re_b_uvw , ov_max is  $re_b_ov_max"
    echo "ucd9090 ovp, $re_9090_ovp, ovw , $re_9090_ovw , uvp , $re_9090_uvp , uvw , $re_9090_uvw"
else
    echo "target vout is not supported, exit the script"
    exit 1 # Exit script after printing help
fi
echo ""
echo "=============================================================================================================================================="
echo "=12v:-10, 1v8:-13, 2v5:-13, 0v85:-14, 1v2:-14, 0v95:-14, 0v84:-14, 0v9_mgt:-14, 0v6:-15, t12v_I:-9(11bit), temp_ext:-(11bit),, temp_int:-(11bit)," 
echo "=============================================================================================================================================="
echo ""
echo "timestamp,12v, 1v8, 2v5, 0v85, 1v2, 0v95, 0v84_ref, 0v9_mgt, 0v6, 12v current, temp_ext, temp_int"
echo "exponent value,-10, -13, -13, -14, -14, -14, -14, -14, -15, -9, -9, -9"
for ((i=1;i<$mon_n;i++))
do
    re_a_vout=$($i2cget_8273_a $r_vout w)
    re_b_vout=$($i2cget_8273_b $r_vout w)
    $i2cset_9090 $r_9090_page $r_9090_APU_rail
    re_9090_apu_v_sta=$($i2cget_9090 $r_sta)
    re_9090_vmon=$($i2cget_9090 $r_vout w) 
    #====1v8, 2v5, 0v9_mgt, 0v85, and 1v2 voltage read============
    $i2cset_9090 $r_9090_page 0x00
    re_12v_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x01
    re_1V8_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x02
    re_2v5_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x03
    re_0v85_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x04
    re_1v2_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x05
    re_0v95_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x06
    re_0v84_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x07
    re_0v9_mgt_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x08
    re_0v6_vol=$($i2cget_9090 $r_vout w)
    $i2cset_9090 $r_9090_page 0x00
    re_12v_temp_e=$($i2cget_9090 $r_temp_e w)
    re_12v_temp_i=$($i2cget_9090 $r_temp_i w)
    re_12v_amp=$($i2cget_9090 $r_current w)
    NOW=$(date +"%T-%m-%d-%Y")
    echo "$NOW, $(($re_12v_vol)), $(($re_1V8_vol)), $(($re_2v5_vol)), $(($re_0v85_vol)), $(($re_1v2_vol)), $(($re_0v95_vol)), $(($re_0v84_vol)), $(($re_0v9_mgt_vol)), $(($re_0v6_vol)), $re_12v_amp, $re_12v_temp_e, $re_12v_temp_i"
    sleep 5
done
