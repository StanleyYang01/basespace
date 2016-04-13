#!/bin/bash

# dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set1_grh/"
  dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set2_grh/"
# dir1="/data/xwang/Basespace/McCullough_Ritzel_Tcells_Runs1-3_grh/"

dir2="/home/xwang/Dropbox/GitHub/basespace/shell"

files=`find $dir1 -name '*_R1_ALL.fastq'`

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/_R1_ALL.fastq/}
  echo $name3
# qsub -v arg=$name3 $dir2/trim.sh
  qsub -v arg=$name3 $dir2/rsem.sh
done
  
