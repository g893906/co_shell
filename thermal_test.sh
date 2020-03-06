#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -ht parameterA -lt parameterB -lp parameterC"
   echo -e "\t-h Description of what is high power duty"
   echo -e "\t-l Description of what is low power duty in seconds"
   echo -e "\t-n Description of how many loops you want to run"
   exit 1 # Exit script after printing help
}

while getopts "h:l:n:" opt
do
   case "$opt" in
      h ) high_duty="$OPTARG" ;;
      l ) low_duty="$OPTARG" ;;
      n ) loop_cnt="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$high_duty" ] || [ -z "$low_duty" ] || [ -z "$loop_cnt" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

echo "Total argument: $#"
echo "high power duty: $high_duty"
echo "low power duty: $low_duty"
echo "loop count: $loop_cnt"

npass=16777216
npass=$((npass/high_duty))
for ((i=1;i<$loop_cnt;i++))
do
  echo "# Smoke test @400MHz 16section run:$i";
  echo "./test_ghl_ifin_0 iters=4096 npass=$npass >> smoke_test.txt"
  echo "Sleep 72 secs., then run next smoke"
  echo "sleep $low_duty;"
done
