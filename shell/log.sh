#!/bin/bash

cd /home/xwang/Dropbox/GitHub/basespace/shell/log.rsem

files=`find ./myeloid -name 'rsem.sh.e*'`

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/.e/.o}
  echo $name2
  echo $name3
  grep "reads with at least one" ./myeloid/$name2 >> rsem.e
  sed -n '1p' ./myeloid/$name3 >> rsem.o
done

awk  '{gsub(/^.*\//, "", $0); print}' rsem.o > rsem.o1
awk  '{gsub(/_LaneALL.*/, "", $0); print}' rsem.o1 > rsem.o2

paste rsem.o2 rsem.e > rsem.out
  
