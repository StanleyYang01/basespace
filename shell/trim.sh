#!/bin/sh
#PBS -l mem=128gb,nodes=1:ppn=5,walltime=1:00:00

# RNA-seq data analysis pipeline 
# Author: XuLong Wang (xulong.wang@jax.org)

# Read trimming with Trimmomatic

file=${arg}

module load java/1.7.0

# dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set1_grh"
# dir2="/data/xwang/Basespace/myeloid_set1"

# dir1="/data/xwang/Basespace/McCullough_Ritzel_myeloid_set2_grh"
# dir2="/data/xwang/Basespace/myeloid_set2"

# dir1="/data/xwang/Basespace/McCullough_Ritzel_Tcells_Runs1-3_grh"
# dir2="/data/xwang/Basespace/tcells_r123"

  dir1="/data/xwang/exome/merged"
  dir2="/data/xwang/exome/trimmed"

java -jar ~/Trimmomatic-0.32/trimmomatic-0.32.jar PE -threads 5 -phred33 \
            "$dir1"/"$file"_R1.fastq.gz \
            "$dir1"/"$file"_R2.fastq.gz \
            "$dir2"/"$file"_R1.fastq \
            "$dir2"/"$file"_unpaired_R1.fastq \
            "$dir2"/"$file"_R2.fastq \
            "$dir2"/"$file"_unpaired_R2.fastq \
            LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:60 HEADCROP:3

