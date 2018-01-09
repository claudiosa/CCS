#!/bin/sh

rm $0

evince "brincando_com_latex.tex.dvi"

echo "

------------------
(program exited with code: $?)" 		


echo "Press return to continue"
#to be more compatible with shells like dash
dummy_var=""
read dummy_var
