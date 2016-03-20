#!/bin/bash
for source in *.mzn; do
    echo " ..."
    Xname=$(basename $source)  ## nome completo
    ext=${fname##*.}  # file extension
    Yname="${Xname%\.*}"  # base filename (no extension) 
    echo "compiling $source"
        #mzn-g12fd -a $source -o  ${Yname}.txt
	mzn-gecode --all-solutions -s $source --output-to-file  ${Yname}.txt
    echo "Output file => ${Yname}.txt"
done
exit 0