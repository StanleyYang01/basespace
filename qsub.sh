#!/bin/bash

dir1="/data/xwang/MATS/Trimmed"
dir2="/home/xwang/Dropbox/GitHub/basespace"

files=`find $dir1 -name '*_unpaired_R1.fastq'`

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/_unpaired_R1.fastq/}
  echo $name3
  qsub -v arg=$name3 $dir2/rsem.sh
done
  
