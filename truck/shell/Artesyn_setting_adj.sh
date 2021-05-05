#/bin/bash
#This script is used for Artesyn LGA80D 2modules 4phase 1V adjustment

helpFunction()
{
    echo ""
    echo "Usage: $0 -s parameterB"
    echo -e "\t-s Description of setting/reading the power module, 1: for reading, 2: for setting, 3: no operation"
    echo -e "\t-d Description of which device you want to read/set, 1: for Renesas, 2: for Artesyn"
    echo -e "\t-r Description of which device you want to restore_factory, 1: reset as factory, 2: no operation"
    exit 1 # Exit script after printing help
}

while getopts "s:d:r:" opt
do
    case "$opt" in
        s ) option="$OPTARG";;
        d ) device="$OPTARG";;
        r ) reset="$OPTARG";;
        ? ) helpfunction;; #Print helpFunction in case parameter is non-existent
    esac
done

# Print helpFunction in case parameter are empty
if [ -z $option ] || [ -z $device ] || [ -z $reset ] || [ $option -lt 1 ] || [ $option -gt 3 ] || [ $device -lt 1 ] || [ $device -gt 2 ] || [ $reset -lt 1 ] || [ $reset -gt 2 ]

then
    echo "The option read/write should be 1, 2,or 3";
    echo "The device selection should be 1 or 2";
    echo "The reset selection should be 1 or 2";
    helpFunction
fi


echo "Totalargument: $#"
echo "Option is: $option (1 for reading, 2 for setting, 3 for no opweration)"
echo "Device is: $device (1 for Renesas, 2 for Artesyn)"
echo "Reset is: $reset (1 for reset to factory, 2 no operation)"

i2cset_80D="i2cset -f -y 1"
i2cget_80D="i2cget -f -y 1"
if [ $device -eq 2 ]
then
master="0x43"
slave="0x42"
elif [ $device -eq 1 ]
then
master="0x19"
slave="0x1a"
fi
r_RESTORE_FACTORY="0xF4"
r_RESTORE_USER_ALL="0x16"
r_STORE_USER_ALL="0x15"
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

h_FREQUENCY_SWITCH="0xFB92"           #2bytes
h_VIN_UV_FAULT_LIMIT="0xCB10"         #2bytes
h_VIN_UV_WARN_LIMIT="0xCB5E"          #2bytes
h_VIN_OV_FAULT_LIMIT="0xD393"         #2bytes
h_VIN_OV_WARN_LIMIT="0xD360"          #2bytes
h_OT_FAULT_LIMIT="0xEBE8"             #2bytes
h_OT_WARN_LIMIT="0xEB70"              #2bytes
h_VOUT_OV_FAULT_LIMIT="0x2333"        #2bytes
h_IOUT_AVG_OC_FAULT_LIMIT="0xE2D0"    #2bytes
h_IOUT_OC_FAULT_LIMIT="0xE320"        #2bytes
h_IOUT_CAL_GAIN="0xB376"              #2bytes
h_IOUT_CAL_OFFSET="0xB533"            #2bytes
h_IOUT_UC_FAULT_LIMIT="0xEDD0"        #2bytes
h_ISENSE_CONFIG="0x320E"              #2bytes
h_IOUT_AVG_UC_FAULT_LIMIT="0xE4E0"    #2bytes
h_VOUT_COMMAND="0x2000"               #2bytes
h_VOUT_MAX="0x22F6"                   #2bytes
h_VOUT_UV_FAULT_LIMIT="0x1B34"        #2bytes
h_VOUT_MARGIN_HIGH="0x2199"           #2bytes
h_VOUT_MARGIN_LOW="0x1E67"            #2bytes
h_POWER_GOOD_ON="0x1CCD"              #2bytes
h_INTERLEAVE="0x0000"                 #2bytes
h_VOUT_DROOP="0x9A3D"                 #2bytes
h_MULTI_PHASE_RAMP_GAIN="0x03"        #1byte


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
            echo "FREQUENCY_SWITCH ,        $($i2cget_80D $addr $r_FREQUENCY_SWITCH w)"       
            echo "VIN_UV_FAULT_LIMIT ,      $($i2cget_80D $addr $r_VIN_UV_FAULT_LIMIT w)"     
            echo "VIN_UV_WARN_LIMIT ,       $($i2cget_80D $addr $r_VIN_UV_WARN_LIMIT w)"      
            echo "VIN_OV_FAULT_LIMIT ,      $($i2cget_80D $addr $r_VIN_OV_FAULT_LIMIT w)"     
            echo "VIN_OV_WARN_LIMIT ,       $($i2cget_80D $addr $r_VIN_OV_WARN_LIMIT w)"      
            echo "OT_FAULT_LIMIT ,          $($i2cget_80D $addr $r_OT_FAULT_LIMIT w)"         
            echo "OT_WARN_LIMIT ,           $($i2cget_80D $addr $r_OT_WARN_LIMIT w)"          
            echo "VOUT_OV_FAULT_LIMIT ,     $($i2cget_80D $addr $r_VOUT_OV_FAULT_LIMIT w)"    
            echo "IOUT_AVG_OC_FAULT_LIMIT,  $($i2cget_80D $addr $r_IOUT_AVG_OC_FAULT_LIMIT w)"
            echo "IOUT_OC_FAULT_LIMIT ,     $($i2cget_80D $addr $r_IOUT_OC_FAULT_LIMIT w)"    
            echo "IOUT_CAL_GAIN ,           $($i2cget_80D $addr $r_IOUT_CAL_GAIN w)"          
            echo "IOUT_CAL_OFFSET ,         $($i2cget_80D $addr $r_IOUT_CAL_OFFSET w)"        
            echo "IOUT_UC_FAULT_LIMIT ,     $($i2cget_80D $addr $r_IOUT_UC_FAULT_LIMIT w)"    
            echo "ISENSE_CONFIG ,           $($i2cget_80D $addr $r_ISENSE_CONFIG w)"          
            echo "IOUT_AVG_UC_FAULT_LIMIT,  $($i2cget_80D $addr $r_IOUT_AVG_UC_FAULT_LIMIT w)"
            echo "VOUT_COMMAND ,            $($i2cget_80D $addr $r_VOUT_COMMAND w)"      
            echo "VOUT_MAX ,                $($i2cget_80D $addr $r_VOUT_MAX w)"               
            echo "VOUT_UV_FAULT_LIMIT ,     $($i2cget_80D $addr $r_VOUT_UV_FAULT_LIMIT w)"
            echo "VOUT_MARGIN_HIGH ,        $($i2cget_80D $addr $r_VOUT_MARGIN_HIGH w)"
            echo "VOUT_MARGIN_LOW ,         $($i2cget_80D $addr $r_VOUT_MARGIN_LOW w)"
            echo "POWER_GOOD_ON ,           $($i2cget_80D $addr $r_POWER_GOOD_ON w)"
            echo "INTERLEAVE ,              $($i2cget_80D $addr $r_INTERLEAVE w)"
            echo "VOUT_DROOP ,              $($i2cget_80D $addr $r_VOUT_DROOP w)"
            echo "MULTI_PHASE_RAMP_GAIN,    $($i2cget_80D $addr $r_MULTI_PHASE_RAMP_GAIN)"
        done
    done

elif [ $option -eq 2 ]
then
    echo "command is as below"
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
            echo "$i2cset_80D $addr $r_FREQUENCY_SWITCH $h_FREQUENCY_SWITCH w"       
            echo "$i2cset_80D $addr $r_VIN_UV_FAULT_LIMIT $h_VIN_UV_FAULT_LIMIT w"     
            echo "$i2cset_80D $addr $r_VIN_UV_WARN_LIMIT $h_VIN_UV_WARN_LIMIT w"      
            echo "$i2cset_80D $addr $r_VIN_OV_FAULT_LIMIT $h_VIN_OV_FAULT_LIMIT w"     
            echo "$i2cset_80D $addr $r_VIN_OV_WARN_LIMIT $h_VIN_OV_WARN_LIMIT w"      
            echo "$i2cset_80D $addr $r_OT_FAULT_LIMIT $h_OT_FAULT_LIMIT w"         
            echo "$i2cset_80D $addr $r_OT_WARN_LIMIT $h_OT_WARN_LIMIT w"          
            echo "$i2cset_80D $addr $r_VOUT_OV_FAULT_LIMIT $h_VOUT_OV_FAULT_LIMIT w"    
            echo "$i2cset_80D $addr $r_IOUT_AVG_OC_FAULT_LIMIT $h_IOUT_AVG_OC_FAULT_LIMIT w"
            echo "$i2cset_80D $addr $r_IOUT_OC_FAULT_LIMIT $h_IOUT_OC_FAULT_LIMIT w"    
            echo "$i2cset_80D $addr $r_IOUT_CAL_GAIN $h_IOUT_CAL_GAIN w"          
            echo "$i2cset_80D $addr $r_IOUT_CAL_OFFSET $h_IOUT_CAL_OFFSET w"        
            echo "$i2cset_80D $addr $r_IOUT_UC_FAULT_LIMIT $h_IOUT_UC_FAULT_LIMIT w"    
            echo "$i2cset_80D $addr $r_ISENSE_CONFIG $h_ISENSE_CONFIG w"          
            echo "$i2cset_80D $addr $r_IOUT_AVG_UC_FAULT_LIMIT $h_IOUT_AVG_UC_FAULT_LIMIT w"
            echo "$i2cset_80D $addr $r_VOUT_COMMAND $h_VOUT_COMMAND w"      
            echo "$i2cset_80D $addr $r_VOUT_MAX $h_VOUT_MAX w"               
            echo "$i2cset_80D $addr $r_VOUT_UV_FAULT_LIMIT $h_VOUT_UV_FAULT_LIMIT w"
            echo "$i2cset_80D $addr $r_VOUT_MARGIN_HIGH $h_VOUT_MARGIN_HIGH w"
            echo "$i2cset_80D $addr $r_VOUT_MARGIN_LOW $h_VOUT_MARGIN_LOW w"
            echo "$i2cset_80D $addr $r_POWER_GOOD_ON $h_POWER_GOOD_ON w"
            echo "$i2cset_80D $addr $r_INTERLEAVE $h_INTERLEAVE w"
            echo "$i2cset_80D $addr $r_VOUT_DROOP $h_VOUT_DROOP w"
            echo "$i2cset_80D $addr $r_MULTI_PHASE_RAMP_GAIN $h_MULTI_PHASE_RAMP_GAIN"
        done
    done
fi


if [ $reset -eq 1 ]
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
        #for j in {0..1}
        #do
            #$i2cset_80D $addr $r_PAGE $j
            $i2cset_80D $addr $r_RESTORE_FACTORY
	    sleep 5 
            #$i2cset_80D $addr $r_RESTORE_USER_ALL
            $i2cset_80D $addr $r_STORE_USER_ALL
        #done
    done
fi

