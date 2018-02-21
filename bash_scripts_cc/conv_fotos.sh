#!/bin/bash
echo "Converte imagens jpg para o formato 640x480 (or 480x640)"
echo " APAGANDO as fotos ORIGINAIS "
for i in *.jpg ; ##  ou JPG
do 
convert -size 640x480 $i -resize 640x480   NOVA.$i;
##    convert -size 640x480 $i -resize 640x480 $i.NOVA;
#  convert -size 480x640 $i -resize 480x640 $i;
echo "Resized image $i created. ==> OK ...  NOVA....jpg" ; 
done 
mkdir temp
mv NOVA.* temp/
echo "Tudo em temp" ; 
