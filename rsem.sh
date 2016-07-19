#!/bin/sh

# dir1=/home/xulong/local/basespace/test
dir1=/home/xulong/local/basespace/trimmed

dir2=/home/xulong/local/basespace/rsem

files=`find $dir1 -name '*unpaired_R1.fastq'`

myrsem=/home/xulong/RSEM-1.2.25/rsem-calculate-expression
mybowtie2=/home/xulong/bowtie2-2.2.6
myref=/home/xulong/mouse/rsem/grcm38

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/_unpaired_R1.fastq/}
  echo $name3

  $myrsem -p 20 --phred33-quals \
          --bowtie2 --bowtie2-path $mybowtie2 \
   	  --forward-prob 1 --paired-end \
          $dir1/${name3}_R1.fastq $dir1/${name3}_R2.fastq \
   	  $myref $dir2/$name3
done

