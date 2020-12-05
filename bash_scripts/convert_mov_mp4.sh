#!/bin/bash
for i in *.mov;
do
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i "$i" -q:v 0 "$name.mp4"
done
echo " ..... DONE ALL -- all quality conversion ......"

##    %avconv -i "$i" -vcodec libx264 -acodec aac -strict experimental  -threads 3 "$name.mp4";
# ffmpeg -i ${input_file} -y -target ${format}-dvd -sameq -aspect 16:9 finalmovie.mpg
