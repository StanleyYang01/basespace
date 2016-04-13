#!/bin/bash

# dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set1_grh/"
# dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set2_grh/"
  dir1="/data/xwang/Basespace/McCullough_Ritzel_Tcells_Runs1-3_grh/"

files=`find $dir1 -name '*_R1_ALL.fastq'`

for name1 in $files; do
  echo $name1
  wc -l $name1
done
  
