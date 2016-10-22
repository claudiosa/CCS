#!/bin/bash

for i in *.avi;
do
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i "$i"  "$name.mpg"
done
##    %avconv -i "$i" -vcodec libx264 -acodec aac -strict experimental  -threads 3 "$name.mp4";
# ffmpeg -i ${input_file} -y -target ${format}-dvd -sameq -aspect 16:9 finalmovie.mpg
