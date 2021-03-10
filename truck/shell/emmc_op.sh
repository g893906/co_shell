#!/bin/bash
cd /run/media/mmcblk0p1
mkdir tmp
mkdir tmp1
for i in {1..100};
do
  time;
  echo "# $i copy BOOT.bin to tmp";
  cp BOOT.BIN tmp/
  echo "# $i copy BOOT.BIN from tmp to tmp1";
  cp tmp/BOOT.BIN tmp1/
  echo "del tmp/BOOT.BIN tmp1/BOOT.BIN"
  rm tmp/BOOT.BIN tmp1/BOOT.BIN
done
