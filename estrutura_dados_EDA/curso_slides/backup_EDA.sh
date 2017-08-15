#!/bin/bash

rm -f *.acn *.alg *.aux *.bbl *.blg *.brf *.fls *.glsdefs *.glo *.ilg *.ind *.ist *.lof *.log *.lol *.lot *.maf *.mtc* *.nav *.out *.snm *.spl *.synctex.* *.toc *.upa *.upb *.vrb 
echo "Feito CLEAN"
rsync   -avzrul   --delete  ~ccs/Dropbox/CCS/estrutura_dados_EDA/ ~ccs/Dropbox/cursos/eda/estrutura_dados_EDA/
echo "Feito Backup"
echo "OK ... passou!"
