#!/bin/bash
#This script is to lower the quality to save memory to watch movie / drama on your mobile.
for i in $(ls -1 *.avi); 
 do
 echo item: $i
 ffmpeg -i $i $i.mpg
done
