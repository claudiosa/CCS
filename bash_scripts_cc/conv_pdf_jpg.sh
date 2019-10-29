#!/bin/bash
for i in *.pdf ; ##  ou JPG
do 
convert  $i $i.jpg ;
done 

#perl-rename -n 's/[0-z]\.pdf\.jpg/\.jpg/' *.jpg
#perl-rename  's/[0-z]\.pdf\.jpg/[0-z]\.jpg/' *.jpg

echo "DONE" ; 
