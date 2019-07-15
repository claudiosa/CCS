#!/bin/bash
for f in *.pdf; 
  do i="${f%.pdf}"; 
  mv -i -- "$f" "${i//./_}.pdf";
 done
echo "DONE"



#for arquivo in *.JPG.jpg
#for arquivo in *.*.pdf
#do
#mv $arquivo `echo $arquivo |cut -d. -f1 ` $1_$2.pdf
#cp $arquivo  ${arquivo/*.*.pdf/*_*.pdf}
#mv "$arquivo" "$(echo $arquivo | sed "s/*.*.pdf/*_*.pdf/")"
#done
#for i in *-doc-*.txt; do mv $i ${i/*-doc-/doc-}; done


#for file in *.pdf
#do
#mv "$file" $(echo "$file" | sed 's/[^A-Za-z0-9.^A-Za-z0-9.]/_/g')
#done

### rename 's/6.[0-9]+\.pdf/6\_[0-9]+\.pdf/' *.pdf
##rename -v 'y/6.*\.pdf$/6\_*\.pdf/' *.pdf
