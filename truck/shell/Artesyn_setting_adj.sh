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
if [ $margin -lt 1 ] || [ $margin -gt 2 ]
then
    echo "The option should be 1 or 2";
    helpFunction
fi


echo "Totalargument: $#"
echo "Option is: $target (1 for reading, 2 for setting)"

i2cset_80D_m="i2cset -f -y 1 0x43"
i2cset_80D_s="i2cset -f -y 1 0x42"
i2cget_80D_m="i2cget -f -y 1 0x43"
i2cget_80D_s="i2cget -f -y 1 0x42"
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
    $i2cset_80D_m $r_PAGE $h_PAGE_0
    h_FREQUENCY_SWITCH=$($i2cget_80D_m $r_FREQUENCY_SWITCH w)       
    h_VIN_UV_FAULT_LIMIT=$($i2cget_80D_m $r_VIN_UV_FAULT_LIMIT w)     
    h_VIN_UV_WARN_LIMIT=$($i2cget_80D_m $r_VIN_UV_WARN_LIMIT w)      
    h_VIN_OV_FAULT_LIMIT=$($i2cget_80D_m $r_VIN_OV_FAULT_LIMIT w)     
    h_VIN_OV_WARN_LIMIT=$($i2cget_80D_m $r_VIN_OV_WARN_LIMIT w)      
    h_OT_FAULT_LIMIT=$($i2cget_80D_m $r_OT_FAULT_LIMIT w)         
    h_OT_WARN_LIMIT=$($i2cget_80D_m $r_OT_WARN_LIMIT w)          
    h_VOUT_OV_FAULT_LIMIT=$($i2cget_80D_m $r_VOUT_OV_FAULT_LIMIT w)    
    h_IOUT_AVG_OC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_AVG_OC_FAULT_LIMIT w)
    h_IOUT_OC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_OC_FAULT_LIMIT w)    
    h_IOUT_CAL_GAIN=$($i2cget_80D_m $r_IOUT_CAL_GAIN w)          
    h_IOUT_CAL_OFFSET=$($i2cget_80D_m $r_IOUT_CAL_OFFSET w)        
    h_IOUT_UC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_UC_FAULT_LIMIT w)    
    h_ISENSE_CONFIG=$($i2cget_80D_m $r_ISENSE_CONFIG w)          
    h_IOUT_AVG_UC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_AVG_UC_FAULT_LIMIT w)
    h_VOUT_COMMAND=$($i2cget_80D_m $r_VOUT_COMMAND w)      
    h_VOUT_MAX=$($i2cget_80D_m $r_VOUT_MAX w)               
    h_VOUT_UV_FAULT_LIMIT=$($i2cget_80D_m $r_VOUT_UV_FAULT_LIMIT w)
    h_VOUT_MARGIN_HIGH=$($i2cget_80D_m $r_VOUT_MARGIN_HIGH w)
    h_VOUT_MARGIN_LOW=$($i2cget_80D_m $r_VOUT_MARGIN_LOW w)
    h_POWER_GOOD_ON=$($i2cget_80D_m $r_POWER_GOOD_ON w)
    h_INTERLEAVE=$($i2cget_80D_m $r_INTERLEAVE w)
    h_VOUT_DROOP=$($i2cget_80D_m $r_VOUT_DROOP w)
    h_MULTI_PHASE_RAMP_GAIN=$($i2cget_80D_m $r_MULTI_PHASE_RAMP_GAIN)
    echo "h_FREQUENCY_SWITCH, h_VIN_UV_FAULT_LIMIT, h_VIN_UV_WARN_LIMIT, h_VIN_OV_FAULT_LIMIT, h_VIN_OV_WARN_LIMIT, h_OT_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_IOUT_AVG_OC_FAULT_LIMIT, h_IOUT_OC_FAULT_LIMIT, h_IOUT_CAL_GAIN, h_IOUT_CAL_OFF, h_IOUT_UC_FAULT_LIMIT, h_ISENSE_CONFIG,  h_IOUT_AVG_UC_FAULT_LIMIT, h_VOUT_COMMAND, h_VOUT_MAX, h_VOUT_UV_FAULT_LIMIT, h_VOUT_MARGIN_HIGH, h_VOUT_MARGIN_LOW, h_POWER_GOOD_ON, h_INTERLEAVE, h_VOUT_DROOP, h_MULTI_PHASE_RAMP_GAIN"
    echo "$h_FREQUENCY_SWITCH, $h_VIN_UV_FAULT_LIMIT, $h_VIN_UV_WARN_LIMIT, $h_VIN_OV_FAULT_LIMIT, $h_VIN_OV_WARN_LIMIT, $h_OT_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_IOUT_AVG_OC_FAULT_LIMIT, $h_IOUT_OC_FAULT_LIMIT, $h_IOUT_CAL_GAIN, $h_IOUT_CAL_OFF, $h_IOUT_UC_FAULT_LIMIT, $h_ISENSE_CONFIG,  $h_IOUT_AVG_UC_FAULT_LIMIT, $h_VOUT_COMMAND, $h_VOUT_MAX, $h_VOUT_UV_FAULT_LIMIT, $h_VOUT_MARGIN_HIGH, $h_VOUT_MARGIN_LOW, $h_POWER_GOOD_ON, $h_INTERLEAVE, $h_VOUT_DROOP, $h_MULTI_PHASE_RAMP_GAIN"

    $i2cset_80D_m $r_PAGE $h_PAGE_1
    h_FREQUENCY_SWITCH=$($i2cget_80D_m $r_FREQUENCY_SWITCH w)       
    h_VIN_UV_FAULT_LIMIT=$($i2cget_80D_m $r_VIN_UV_FAULT_LIMIT w)     
    h_VIN_UV_WARN_LIMIT=$($i2cget_80D_m $r_VIN_UV_WARN_LIMIT w)      
    h_VIN_OV_FAULT_LIMIT=$($i2cget_80D_m $r_VIN_OV_FAULT_LIMIT w)     
    h_VIN_OV_WARN_LIMIT=$($i2cget_80D_m $r_VIN_OV_WARN_LIMIT w)      
    h_OT_FAULT_LIMIT=$($i2cget_80D_m $r_OT_FAULT_LIMIT w)         
    h_OT_WARN_LIMIT=$($i2cget_80D_m $r_OT_WARN_LIMIT w)          
    h_VOUT_OV_FAULT_LIMIT=$($i2cget_80D_m $r_VOUT_OV_FAULT_LIMIT w)    
    h_IOUT_AVG_OC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_AVG_OC_FAULT_LIMIT w)
    h_IOUT_OC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_OC_FAULT_LIMIT w)    
    h_IOUT_CAL_GAIN=$($i2cget_80D_m $r_IOUT_CAL_GAIN w)          
    h_IOUT_CAL_OFFSET=$($i2cget_80D_m $r_IOUT_CAL_OFFSET w)        
    h_IOUT_UC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_UC_FAULT_LIMIT w)    
    h_ISENSE_CONFIG=$($i2cget_80D_m $r_ISENSE_CONFIG w)          
    h_IOUT_AVG_UC_FAULT_LIMIT=$($i2cget_80D_m $r_IOUT_AVG_UC_FAULT_LIMIT w)
    h_VOUT_COMMAND=$($i2cget_80D_m $r_VOUT_COMMAND w)      
    h_VOUT_MAX=$($i2cget_80D_m $r_VOUT_MAX w)               
    h_VOUT_UV_FAULT_LIMIT=$($i2cget_80D_m $r_VOUT_UV_FAULT_LIMIT w)
    h_VOUT_MARGIN_HIGH=$($i2cget_80D_m $r_VOUT_MARGIN_HIGH w)
    h_VOUT_MARGIN_LOW=$($i2cget_80D_m $r_VOUT_MARGIN_LOW w)
    h_POWER_GOOD_ON=$($i2cget_80D_m $r_POWER_GOOD_ON w)
    h_INTERLEAVE=$($i2cget_80D_m $r_INTERLEAVE w)
    h_VOUT_DROOP=$($i2cget_80D_m $r_VOUT_DROOP w)
    h_MULTI_PHASE_RAMP_GAIN=$($i2cget_80D_m $r_MULTI_PHASE_RAMP_GAIN)
    echo "h_FREQUENCY_SWITCH, h_VIN_UV_FAULT_LIMIT, h_VIN_UV_WARN_LIMIT, h_VIN_OV_FAULT_LIMIT, h_VIN_OV_WARN_LIMIT, h_OT_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_IOUT_AVG_OC_FAULT_LIMIT, h_IOUT_OC_FAULT_LIMIT, h_IOUT_CAL_GAIN, h_IOUT_CAL_OFF, h_IOUT_UC_FAULT_LIMIT, h_ISENSE_CONFIG,  h_IOUT_AVG_UC_FAULT_LIMIT, h_VOUT_COMMAND, h_VOUT_MAX, h_VOUT_UV_FAULT_LIMIT, h_VOUT_MARGIN_HIGH, h_VOUT_MARGIN_LOW, h_POWER_GOOD_ON, h_INTERLEAVE, h_VOUT_DROOP, h_MULTI_PHASE_RAMP_GAIN"
    echo "$h_FREQUENCY_SWITCH, $h_VIN_UV_FAULT_LIMIT, $h_VIN_UV_WARN_LIMIT, $h_VIN_OV_FAULT_LIMIT, $h_VIN_OV_WARN_LIMIT, $h_OT_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_IOUT_AVG_OC_FAULT_LIMIT, $h_IOUT_OC_FAULT_LIMIT, $h_IOUT_CAL_GAIN, $h_IOUT_CAL_OFF, $h_IOUT_UC_FAULT_LIMIT, $h_ISENSE_CONFIG,  $h_IOUT_AVG_UC_FAULT_LIMIT, $h_VOUT_COMMAND, $h_VOUT_MAX, $h_VOUT_UV_FAULT_LIMIT, $h_VOUT_MARGIN_HIGH, $h_VOUT_MARGIN_LOW, $h_POWER_GOOD_ON, $h_INTERLEAVE, $h_VOUT_DROOP, $h_MULTI_PHASE_RAMP_GAIN"

    $i2cset_80D_s $r_PAGE $h_PAGE_0
    h_FREQUENCY_SWITCH=$($i2cget_80D_s $r_FREQUENCY_SWITCH w)       
    h_VIN_UV_FAULT_LIMIT=$($i2cget_80D_s $r_VIN_UV_FAULT_LIMIT w)     
    h_VIN_UV_WARN_LIMIT=$($i2cget_80D_s $r_VIN_UV_WARN_LIMIT w)      
    h_VIN_OV_FAULT_LIMIT=$($i2cget_80D_s $r_VIN_OV_FAULT_LIMIT w)     
    h_VIN_OV_WARN_LIMIT=$($i2cget_80D_s $r_VIN_OV_WARN_LIMIT w)      
    h_OT_FAULT_LIMIT=$($i2cget_80D_s $r_OT_FAULT_LIMIT w)         
    h_OT_WARN_LIMIT=$($i2cget_80D_s $r_OT_WARN_LIMIT w)          
    h_VOUT_OV_FAULT_LIMIT=$($i2cget_80D_s $r_VOUT_OV_FAULT_LIMIT w)    
    h_IOUT_AVG_OC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_AVG_OC_FAULT_LIMIT w)
    h_IOUT_OC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_OC_FAULT_LIMIT w)    
    h_IOUT_CAL_GAIN=$($i2cget_80D_s $r_IOUT_CAL_GAIN w)          
    h_IOUT_CAL_OFFSET=$($i2cget_80D_s $r_IOUT_CAL_OFFSET w)        
    h_IOUT_UC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_UC_FAULT_LIMIT w)    
    h_ISENSE_CONFIG=$($i2cget_80D_s $r_ISENSE_CONFIG w)          
    h_IOUT_AVG_UC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_AVG_UC_FAULT_LIMIT w)
    h_VOUT_COMMAND=$($i2cget_80D_s $r_VOUT_COMMAND w)      
    h_VOUT_MAX=$($i2cget_80D_s $r_VOUT_MAX w)               
    h_VOUT_UV_FAULT_LIMIT=$($i2cget_80D_s $r_VOUT_UV_FAULT_LIMIT w)
    h_VOUT_MARGIN_HIGH=$($i2cget_80D_s $r_VOUT_MARGIN_HIGH w)
    h_VOUT_MARGIN_LOW=$($i2cget_80D_s $r_VOUT_MARGIN_LOW w)
    h_POWER_GOOD_ON=$($i2cget_80D_s $r_POWER_GOOD_ON w)
    h_INTERLEAVE=$($i2cget_80D_s $r_INTERLEAVE w)
    h_VOUT_DROOP=$($i2cget_80D_s $r_VOUT_DROOP w)
    h_MULTI_PHASE_RAMP_GAIN=$($i2cget_80D_s $r_MULTI_PHASE_RAMP_GAIN)
    echo "h_FREQUENCY_SWITCH, h_VIN_UV_FAULT_LIMIT, h_VIN_UV_WARN_LIMIT, h_VIN_OV_FAULT_LIMIT, h_VIN_OV_WARN_LIMIT, h_OT_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_IOUT_AVG_OC_FAULT_LIMIT, h_IOUT_OC_FAULT_LIMIT, h_IOUT_CAL_GAIN, h_IOUT_CAL_OFF, h_IOUT_UC_FAULT_LIMIT, h_ISENSE_CONFIG,  h_IOUT_AVG_UC_FAULT_LIMIT, h_VOUT_COMMAND, h_VOUT_MAX, h_VOUT_UV_FAULT_LIMIT, h_VOUT_MARGIN_HIGH, h_VOUT_MARGIN_LOW, h_POWER_GOOD_ON, h_INTERLEAVE, h_VOUT_DROOP, h_MULTI_PHASE_RAMP_GAIN"
    echo "$h_FREQUENCY_SWITCH, $h_VIN_UV_FAULT_LIMIT, $h_VIN_UV_WARN_LIMIT, $h_VIN_OV_FAULT_LIMIT, $h_VIN_OV_WARN_LIMIT, $h_OT_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_IOUT_AVG_OC_FAULT_LIMIT, $h_IOUT_OC_FAULT_LIMIT, $h_IOUT_CAL_GAIN, $h_IOUT_CAL_OFF, $h_IOUT_UC_FAULT_LIMIT, $h_ISENSE_CONFIG,  $h_IOUT_AVG_UC_FAULT_LIMIT, $h_VOUT_COMMAND, $h_VOUT_MAX, $h_VOUT_UV_FAULT_LIMIT, $h_VOUT_MARGIN_HIGH, $h_VOUT_MARGIN_LOW, $h_POWER_GOOD_ON, $h_INTERLEAVE, $h_VOUT_DROOP, $h_MULTI_PHASE_RAMP_GAIN"

    $i2cset_80D_s $r_PAGE $h_PAGE_1
    h_FREQUENCY_SWITCH=$($i2cget_80D_s $r_FREQUENCY_SWITCH w)       
    h_VIN_UV_FAULT_LIMIT=$($i2cget_80D_s $r_VIN_UV_FAULT_LIMIT w)     
    h_VIN_UV_WARN_LIMIT=$($i2cget_80D_s $r_VIN_UV_WARN_LIMIT w)      
    h_VIN_OV_FAULT_LIMIT=$($i2cget_80D_s $r_VIN_OV_FAULT_LIMIT w)     
    h_VIN_OV_WARN_LIMIT=$($i2cget_80D_s $r_VIN_OV_WARN_LIMIT w)      
    h_OT_FAULT_LIMIT=$($i2cget_80D_s $r_OT_FAULT_LIMIT w)         
    h_OT_WARN_LIMIT=$($i2cget_80D_s $r_OT_WARN_LIMIT w)          
    h_VOUT_OV_FAULT_LIMIT=$($i2cget_80D_s $r_VOUT_OV_FAULT_LIMIT w)    
    h_IOUT_AVG_OC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_AVG_OC_FAULT_LIMIT w)
    h_IOUT_OC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_OC_FAULT_LIMIT w)    
    h_IOUT_CAL_GAIN=$($i2cget_80D_s $r_IOUT_CAL_GAIN w)          
    h_IOUT_CAL_OFFSET=$($i2cget_80D_s $r_IOUT_CAL_OFFSET w)        
    h_IOUT_UC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_UC_FAULT_LIMIT w)    
    h_ISENSE_CONFIG=$($i2cget_80D_s $r_ISENSE_CONFIG w)          
    h_IOUT_AVG_UC_FAULT_LIMIT=$($i2cget_80D_s $r_IOUT_AVG_UC_FAULT_LIMIT w)
    h_VOUT_COMMAND=$($i2cget_80D_s $r_VOUT_COMMAND w)      
    h_VOUT_MAX=$($i2cget_80D_s $r_VOUT_MAX w)               
    h_VOUT_UV_FAULT_LIMIT=$($i2cget_80D_s $r_VOUT_UV_FAULT_LIMIT w)
    h_VOUT_MARGIN_HIGH=$($i2cget_80D_s $r_VOUT_MARGIN_HIGH w)
    h_VOUT_MARGIN_LOW=$($i2cget_80D_s $r_VOUT_MARGIN_LOW w)
    h_POWER_GOOD_ON=$($i2cget_80D_s $r_POWER_GOOD_ON w)
    h_INTERLEAVE=$($i2cget_80D_s $r_INTERLEAVE w)
    h_VOUT_DROOP=$($i2cget_80D_s $r_VOUT_DROOP w)
    h_MULTI_PHASE_RAMP_GAIN=$($i2cget_80D_s $r_MULTI_PHASE_RAMP_GAIN)
    echo "h_FREQUENCY_SWITCH, h_VIN_UV_FAULT_LIMIT, h_VIN_UV_WARN_LIMIT, h_VIN_OV_FAULT_LIMIT, h_VIN_OV_WARN_LIMIT, h_OT_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_OT_WARN_LIMIT, h_VOUT_OV_FAULT_LIMIT, h_IOUT_AVG_OC_FAULT_LIMIT, h_IOUT_OC_FAULT_LIMIT, h_IOUT_CAL_GAIN, h_IOUT_CAL_OFF, h_IOUT_UC_FAULT_LIMIT, h_ISENSE_CONFIG,  h_IOUT_AVG_UC_FAULT_LIMIT, h_VOUT_COMMAND, h_VOUT_MAX, h_VOUT_UV_FAULT_LIMIT, h_VOUT_MARGIN_HIGH, h_VOUT_MARGIN_LOW, h_POWER_GOOD_ON, h_INTERLEAVE, h_VOUT_DROOP, h_MULTI_PHASE_RAMP_GAIN"
    echo "$h_FREQUENCY_SWITCH, $h_VIN_UV_FAULT_LIMIT, $h_VIN_UV_WARN_LIMIT, $h_VIN_OV_FAULT_LIMIT, $h_VIN_OV_WARN_LIMIT, $h_OT_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_OT_WARN_LIMIT, $h_VOUT_OV_FAULT_LIMIT, $h_IOUT_AVG_OC_FAULT_LIMIT, $h_IOUT_OC_FAULT_LIMIT, $h_IOUT_CAL_GAIN, $h_IOUT_CAL_OFF, $h_IOUT_UC_FAULT_LIMIT, $h_ISENSE_CONFIG,  $h_IOUT_AVG_UC_FAULT_LIMIT, $h_VOUT_COMMAND, $h_VOUT_MAX, $h_VOUT_UV_FAULT_LIMIT, $h_VOUT_MARGIN_HIGH, $h_VOUT_MARGIN_LOW, $h_POWER_GOOD_ON, $h_INTERLEAVE, $h_VOUT_DROOP, $h_MULTI_PHASE_RAMP_GAIN"

elif [ $option -eq 2 ]
then
    echo "Implementing is ongoing"
else
    echo "option must be 1 for reading and 2 for setting the config, your option is $option"
    helpFunction
fi





