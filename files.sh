#!/bin/bash

cd /home/xulong/local/basespace

files=`find . -type f -name "*.gz"`

for file in $files; do
  echo $file
  cp $file ./raw/
done

