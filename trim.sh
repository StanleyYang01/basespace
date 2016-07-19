#!/bin/sh

dir1="/data/xwang/exome/merged/"
dir2="/data/xwang/exome/trimmed/"

files=`find $dir1 -name '*_R1.fastq.gz'`

mytrim="/home/xwang/Trimmomatic-0.32/trimmomatic-0.32.jar"

for name1 in $files; do
  name2=`basename $name1`
  name3=${name2/_R1.fastq.gz/}
  echo $name3

  java -jar $mytrim PE -threads 10 -phred33 \
            "$dir1"/"$name3"_R1.fastq.gz \
            "$dir1"/"$name3"_R2.fastq.gz \
            "$dir2"/"$name3"_R1.fastq \
            "$dir2"/"$name3"_unpaired_R1.fastq \
            "$dir2"/"$name3"_R2.fastq \
            "$dir2"/"$name3"_unpaired_R2.fastq \
            LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:50 HEADCROP:3
done

#           LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:60 HEADCROP:5
