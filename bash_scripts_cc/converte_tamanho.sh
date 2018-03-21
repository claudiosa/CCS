#!/bin/bash
echo "Converte imagens jpg para o formato 640×480 (or 480×640)"
echo " APAGANDO as fotos ORIGINAIS "
mkdir temp
for i in *.jpg ;
do
convert  -resize 640x480 $i  temp/$i;
# convert -size 480×640 $i -resize 480×640 temp/$i;
done 
echo "Resized image $i created. ==> in temp OK" ;
