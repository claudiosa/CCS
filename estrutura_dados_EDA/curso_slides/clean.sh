#!/bin/bash

cd ..
cp -r curso_slides/  ~ccs/Dropbox/cursos/eda/
echo "Feito Backup"

rm -f *.acn *.alg *.aux *.bbl *.blg *.brf *.fls *.glsdefs *.glo *.ilg *.ind *.ist *.lof *.log *.lol *.lot *.maf *.mtc* *.nav *.out *.snm *.spl *.synctex.* *.toc *.upa *.upb *.vrb 
echo "Feito CLEAN"
