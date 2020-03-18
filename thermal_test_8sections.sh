#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -lt parameterB -lp parameterC"
   echo -e "\t-l Description of what is low power duty in seconds"
   echo -e "\t-n Description of how many loops you want to run"
   exit 1 # Exit script after printing help
}

while getopts "l:n:" opt
do
   case "$opt" in
      l ) low_duty="$OPTARG" ;;
      n ) loop_cnt="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$low_duty" ] || [ -z "$loop_cnt" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

echo "Total argument: $#"
#echo "high power duty: $high_duty"
echo "low power duty: $low_duty"
echo "loop count: $loop_cnt"

#npass=16777216
#npass=$((npass/high_duty))
#high_sec=$((60/high_duty))
for ((i=1;i<$loop_cnt;i++))
do
  echo "============================================"
  echo "# Smoke test @400MHz 8section run:$i";
  echo "high power start:"
  date +"%F %T"
  ./smoker_grad_8sections
  echo "high power end:"
  date +"%F %T"
  echo "Sleep $low_duty secs., then run next smoke"
  sleep $low_duty;
  echo "============================================"
done
