#!/bin/bash

cd /data/xwang/Basespace

files=`find ./myeloid_set1 -name '*_LaneALL_R1.fastq'`

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/_R1.fastq/}
  echo $name3
  cp ./myeloid_set1/${name3}_R1.fastq ./myeloid
  cat ./myeloid_set2/${name3}_R1.fastq >> ./myeloid/${name3}_R1.fastq
  cp ./myeloid_set1/${name3}_R2.fastq ./myeloid
  cat ./myeloid_set2/${name3}_R2.fastq >> ./myeloid/${name3}_R2.fastq
done

