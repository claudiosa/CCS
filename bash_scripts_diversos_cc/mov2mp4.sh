#!/bin/bash
# Script to convert all the .MOV files in the current
# directory to "Universal Apple".MP4 format
# http://askubuntu.com/questions/352920/fastest-way-to-convert-videos-batch-or-single 
# Tested on  Src:Canon S95 -> Destn: iPad2 using ffmpeg installed 
# via homebrew: brew install ffpmeg --use-gcc
                      
# Pradeep Gowda <pradeep@btbytes.com>
# 2011-12-25
# License: Public Domain or GPLv3
 
for ff in *.MOV; 
do
    filename=$(basename $ff)
    extension=${filename##*.}
    filename=${filename%.*}
    #ffmpeg -i ${ff} -f mp4 ${filename}.mp4
     ffmpeg -i ${ff}  ${filename}.mp4
  
 # ffmpeg -i ${ff} -codec:v libx264 -crf 23 -preset medium -codec:a libfdk_aac -vbr 4 \
 # -movflags faststart -vf scale=-1:720,format=yuv420p ${ff}.mp4
done
