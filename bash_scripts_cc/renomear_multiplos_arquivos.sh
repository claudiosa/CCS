#!/bin/bash
#for arquivo in *.JPG.jpg
for arquivo in *.MOV.jpg
do
mv $arquivo `echo $arquivo |cut -d. -f1 `.mov
done