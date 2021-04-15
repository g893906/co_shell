#/bin/bash
#This script is used for Artesyn LGA80D 2modules 4phase 1V adjustment

helpFunction()
{
    echo ""
    echo "Usage: $0 -s parameterB"
    echo -e "\t-s Description of setting/reading the Artesyn LGA80D, 1: for reading, 2: for setting"
    exit 1 # Exit script after printing help
}

while getopts "s:" opt
do
    case "$opt" in
        s ) option="$OPTARG";;
        ? ) helpfunction;; #Print helpFunction in case parameter is non-existent
    esac
done

# Print helpFunction in case parameter are empty
if [ -z $option ] || [ $option -lt 1 ] || [ $option -gt 2 ]
then
    echo "The option should be 1 or 2";
    helpFunction
fi


echo "Totalargument: $#"
echo "Option is: $target (1 for reading, 2 for setting)"

i2cset_80D="i2cset -f -y 1"
i2cget_80D="i2cget -f -y 1"
master="0x43"
slave="0x42"
r_PAGE="0x00"
r_FREQUENCY_SWITCH="0x33"           #2bytes
r_VIN_UV_FAULT_LIMIT="0x59"         #2bytes
r_VIN_UV_WARN_LIMIT="0x58"          #2bytes
r_VIN_OV_FAULT_LIMIT="0x55"         #2bytes
r_VIN_OV_WARN_LIMIT="0x57"          #2bytes
r_OT_FAULT_LIMIT="0x4f"             #2bytes
r_OT_WARN_LIMIT="0x51"              #2bytes
r_VOUT_OV_FAULT_LIMIT="0x40"        #2bytes
r_IOUT_AVG_OC_FAULT_LIMIT="0xE7"    #2bytes
r_IOUT_OC_FAULT_LIMIT="0x46"        #2bytes
r_IOUT_CAL_GAIN="0x38"              #2bytes
r_IOUT_CAL_OFFSET="0x39"            #2bytes
r_IOUT_UC_FAULT_LIMIT="0x4b"        #2bytes
r_ISENSE_CONFIG="0xd0"              #2bytes
r_IOUT_AVG_UC_FAULT_LIMIT="0xe8"    #2bytes
r_VOUT_COMMAND="0x21"               #2bytes
r_VOUT_MAX="0x24"                   #2bytes
r_VOUT_UV_FAULT_LIMIT="0x44"        #2bytes
r_VOUT_MARGIN_HIGH="0x25"           #2bytes
r_VOUT_MARGIN_LOW="0x26"            #2bytes
r_POWER_GOOD_ON="0x5e"              #2bytes
r_INTERLEAVE="0x37"                 #2bytes
r_VOUT_DROOP="0x28"                 #2bytes
r_MULTI_PHASE_RAMP_GAIN="0xd5"      #1byte

h_PAGE_0="0x00"
h_PAGE_1="0x01"
h_PAGE_all="0xff"
if [ $option -eq 1 ]
then
    for i in {0..1}
    do
        if [ $i -eq 0 ]
        then
            addr=$master
        elif [ $i -eq 1 ]
        then
            addr=$slave
        fi
        for j in {0..1}
        do
            echo "$i2cset_80D $addr $r_PAGE $j"
            echo "$i2cget_80D $addr $r_FREQUENCY_SWITCH w"       
            echo "$i2cget_80D $addr $r_VIN_UV_FAULT_LIMIT w"     
            echo "$i2cget_80D $addr $r_VIN_UV_WARN_LIMIT w"      
            echo "$i2cget_80D $addr $r_VIN_OV_FAULT_LIMIT w"     
            echo "$i2cget_80D $addr $r_VIN_OV_WARN_LIMIT w"      
            echo "$i2cget_80D $addr $r_OT_FAULT_LIMIT w"         
            echo "$i2cget_80D $addr $r_OT_WARN_LIMIT w"          
            echo "$i2cget_80D $addr $r_VOUT_OV_FAULT_LIMIT w"    
            echo "$i2cget_80D $addr $r_IOUT_AVG_OC_FAULT_LIMIT w"
            echo "$i2cget_80D $addr $r_IOUT_OC_FAULT_LIMIT w"    
            echo "$i2cget_80D $addr $r_IOUT_CAL_GAIN w"          
            echo "$i2cget_80D $addr $r_IOUT_CAL_OFFSET w"        
            echo "$i2cget_80D $addr $r_IOUT_UC_FAULT_LIMIT w"    
            echo "$i2cget_80D $addr $r_ISENSE_CONFIG w"          
            echo "$i2cget_80D $addr $r_IOUT_AVG_UC_FAULT_LIMIT w"
            echo "$i2cget_80D $addr $r_VOUT_COMMAND w"      
            echo "$i2cget_80D $addr $r_VOUT_MAX w"               
            echo "$i2cget_80D $addr $r_VOUT_UV_FAULT_LIMIT w"
            echo "$i2cget_80D $addr $r_VOUT_MARGIN_HIGH w"
            echo "$i2cget_80D $addr $r_VOUT_MARGIN_LOW w"
            echo "$i2cget_80D $addr $r_POWER_GOOD_ON w"
            echo "$i2cget_80D $addr $r_INTERLEAVE w"
            echo "$i2cget_80D $addr $r_VOUT_DROOP w"
            echo "$i2cget_80D $addr $r_MULTI_PHASE_RAMP_GAIN"
        done
    done

elif [ $option -eq 2 ]
then
    echo "Implementing is ongoing"
else
    echo "option must be 1 for reading and 2 for setting the config, your option is $option"
    helpFunction
fi





