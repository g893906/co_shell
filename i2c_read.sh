#!/bin/bash
#This script is used for Artesyn power brick that implemented in LEDA-E proto4-2 board

i2cset="i2cset -f -y 1"
i2cget="i2cget -f -y 1"
master="0x42"
slave="0x41"
phase1="0"
phase2="1"
page="0x00"
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
iout_fault_limit="0xe7 w"
echo "descrition,module, module phase, register, value"
for j in {0..1000}
do
    $i2cset $master $page $phase1
    module_phase=$($i2cget $master $page) 
    echo "sta_byte,$master,$module_phase, $sta_byte  ,$($i2cget $master  $sta_byte)"
    echo "sta_word,$master,$module_phase, $sta_wd    ,$($i2cget $master  $sta_wd)"
    echo "sta_Vout,$master,$module_phase, $sta_vout  ,$($i2cget $master  $sta_vout)"
    echo "sta_Iout,$master,$module_phase, $sta_iout  ,$($i2cget $master  $sta_iout)"
    echo "sta_Vin,$master,$module_phase,  $sta_in    ,$($i2cget $master   $sta_in)"
    echo "sta_temp,$master,$module_phase, $sta_temp  ,$($i2cget $master  $sta_temp)"
    echo "read_Vin,$master,$module_phase, $read_vin  ,$($i2cget $master  $read_vin)"
    echo "read_Vout,$master,$module_phase,$read_vout ,$($i2cget $master $read_vout)"
    echo "read_Iout,$master,$module_phase,$read_iout ,$($i2cget $master $read_iout)"
    echo "read_temp,$master,$module_phase,$read_temp ,$($i2cget $master $read_temp)"
    echo "read_freq,$master,$module_phase,$read_freq ,$($i2cget $master $read_freq)"
    echo "Iout_falut_limit,$master,$module_phase,$iout_fault_limit,$($i2cget $master $iout_fault_limit)"
    $i2cset $master $page $phase2
    module_phase=$($i2cget $master $page)
    echo "sta_byte,$master,$module_phase, $sta_byte  ,$($i2cget $master  $sta_byte)"
    echo "sta_word,$master,$module_phase, $sta_wd    ,$($i2cget $master  $sta_wd)"
    echo "sta_Vout,$master,$module_phase, $sta_vout  ,$($i2cget $master  $sta_vout)"
    echo "sta_Iout,$master,$module_phase, $sta_iout  ,$($i2cget $master  $sta_iout)"
    echo "sta_Vin,$master,$module_phase,  $sta_in    ,$($i2cget $master   $sta_in)"
    echo "sta_temp,$master,$module_phase, $sta_temp  ,$($i2cget $master  $sta_temp)"
    echo "read_Vin,$master,$module_phase, $read_vin  ,$($i2cget $master  $read_vin)"
    echo "read_Vout,$master,$module_phase,$read_vout ,$($i2cget $master $read_vout)"
    echo "read_Iout,$master,$module_phase,$read_iout ,$($i2cget $master $read_iout)"
    echo "read_temp,$master,$module_phase,$read_temp ,$($i2cget $master $read_temp)"
    echo "read_freq,$master,$module_phase,$read_freq ,$($i2cget $master $read_freq)"
    echo "Iout_falut_limit,$master,$module_phase,$iout_fault_limit,$($i2cget $master $iout_fault_limit)"
	sleep 2
    $i2cset $slave $page $phase1
    module_phase=$($i2cget $slave $page) 
    echo "sta_byte,$slave,$module_phase, $sta_byte  ,$($i2cget $slave  $sta_byte)"
    echo "sta_word,$slave,$module_phase, $sta_wd    ,$($i2cget $slave  $sta_wd)"
    echo "sta_Vout,$slave,$module_phase, $sta_vout  ,$($i2cget $slave  $sta_vout)"
    echo "sta_Iout,$slave,$module_phase, $sta_iout  ,$($i2cget $slave  $sta_iout)"
    echo "sta_Vin,$slave,$module_phase,  $sta_in    ,$($i2cget $slave   $sta_in)"
    echo "sta_temp,$slave,$module_phase, $sta_temp  ,$($i2cget $slave  $sta_temp)"
    echo "read_Vin,$slave,$module_phase, $read_vin  ,$($i2cget $slave  $read_vin)"
    echo "read_Vout,$slave,$module_phase,$read_vout ,$($i2cget $slave $read_vout)"
    echo "read_Iout,$slave,$module_phase,$read_iout ,$($i2cget $slave $read_iout)"
    echo "read_temp,$slave,$module_phase,$read_temp ,$($i2cget $slave $read_temp)"
    echo "read_freq,$slave,$module_phase,$read_freq ,$($i2cget $slave $read_freq)"
    echo "Iout_falut_limit,$slave,$module_phase,$iout_fault_limit,$($i2cget $slave $iout_fault_limit)"
    $i2cset $slave $page $phase2
    module_phase=$($i2cget $slave $page)
    echo "sta_byte,$slave,$module_phase, $sta_byte  ,$($i2cget $slave  $sta_byte)"
    echo "sta_word,$slave,$module_phase, $sta_wd    ,$($i2cget $slave  $sta_wd)"
    echo "sta_Vout,$slave,$module_phase, $sta_vout  ,$($i2cget $slave  $sta_vout)"
    echo "sta_Iout,$slave,$module_phase, $sta_iout  ,$($i2cget $slave  $sta_iout)"
    echo "sta_Vin,$slave,$module_phase,  $sta_in    ,$($i2cget $slave   $sta_in)"
    echo "sta_temp,$slave,$module_phase, $sta_temp  ,$($i2cget $slave  $sta_temp)"
    echo "read_Vin,$slave,$module_phase, $read_vin  ,$($i2cget $slave  $read_vin)"
    echo "read_Vout,$slave,$module_phase,$read_vout ,$($i2cget $slave $read_vout)"
    echo "read_Iout,$slave,$module_phase,$read_iout ,$($i2cget $slave $read_iout)"
    echo "read_temp,$slave,$module_phase,$read_temp ,$($i2cget $slave $read_temp)"
    echo "read_freq,$slave,$module_phase,$read_freq ,$($i2cget $slave $read_freq)"
    echo "Iout_falut_limit,$slave,$module_phase,$iout_fault_limit,$($i2cget $slave $iout_fault_limit)"
	sleep 2
done

