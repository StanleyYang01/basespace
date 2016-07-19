#!/bin/bash

cd /home/xulong/local/basespace/raw

files=`find . -type f -name "*_L001_R1_001.fastq.gz"`

for file in $files; do
  name1=`basename $file`
  name2=${name1/_L001_*/}
  echo $name2
  cat ${name2}_L00[1-4]_R1_001.fastq.gz > ../merged/${name2}_R1.fastq.gz
  cat ${name2}_L00[1-4]_R2_001.fastq.gz > ../merged/${name2}_R2.fastq.gz
done

