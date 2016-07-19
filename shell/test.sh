#!/bin/bash
#PBS -l nodes=1:ppn=10,walltime=10:00:00

module load bowtie
module load samtools
module load fastx
module load fastqc
module load cutadapt
module load rsem

# echo "Build bowtie index for UCSC mm10 whole genome."
# cd /data/xwang/REF
# bowtie-build Mm10Genome.fa Mm10Genome

# cd /data/xwang/Basespace/test

# file="AgedMale-Microglia-4_S14_LaneALL"

# fastx_quality_stats -i ${file}_R1.fastq -o ${file}_R1.txt
# fastq_quality_boxplot_graph.sh -i ${file}_R1.txt -o $HOME/Dropbox/GitHub/basespace/qc/${file}_R1.png

# file="AgedFemale-Microglia-1_S17_LaneALL"

# fastx_quality_stats -i ${file}_R1_ALL.fastq -o ${file}_R1_ALL.txt
# fastq_quality_boxplot_graph.sh -i ${file}_R1_ALL.txt -o $HOME/Dropbox/GitHub/basespace/qc/${file}_R1_ALL.png

# fastqc ${file}_R1.fastq

# file="B6-4251-GES15-02426_GTGAAA_AC6GK3ANXX"
# fastqc -o ~/Dropbox/GitHub/basespace/qc ${file}_R1.fastq

# 

# ref="/data/xwang/RSEM/GRCm38"
# ref="/data/xwang/REF/Mm10Genome"

# java -jar ~/Trimmomatic-0.32/trimmomatic-0.32.jar SE \
#   -threads 20 -phred33 ${file}_R2.fastq ${file}_crop_R2.fastq HEADCROP:6
  
# bowtie -p 20 \
#        --phred33-quals \
#        --chunkmbs 512 \
#        --maxins 1500 \
#        --sam \
#        "$ref" \
#        -1 "$file"_crop_R1.fastq \
#        -2 "$file"_crop_R2.fastq \
#        "$file".sam
 
# bowtie -p 20 \
#        --phred33-quals \
#        --chunkmbs 512 \
#        --maxins 1500 \
#        --un unaligned \
#        --sam \
#        "$ref" \
#        "$file"_crop_R1.fastq \
#        "$file".sam
 
cd /data/xwang/Basespace/pico

file="AgedFemale-Brain-NoStim-13_S10_LaneALL"
ref="/data/xwang/RSEM/GRCm38"

rsem-calculate-expression -p 10 \
  --bowtie-phred33-quals \
  --forward-prob 1 \
  --paired-end \
  "$file"_R1.fastq \
  "$file"_R2.fastq \
  "$ref" \
  "$file"

