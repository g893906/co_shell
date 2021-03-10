#!/bin/bash
for i in {1..1000000};
do
  echo "# $i test the udhcpc";
  udhcpc>>1.txt;
  sleep 10;
done
