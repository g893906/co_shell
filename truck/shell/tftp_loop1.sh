#!/bin/bash
for i in {1..10000};
do
  time;
  echo "# $i test the tftp upload to 192.168.33.60";
  tftp -p -l BOOT1.bin 192.168.33.60;
  echo "# $i test the tftp download from 192.168.33.60";
  tftp -g -r BOOT1.bin 192.168.33.60;
done
