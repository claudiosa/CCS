#!/bin/bash
 pandoc resume.yml  -o resume.pdf --template=FreshTemplate.tex --pdf-engine=xelatex
 echo "DONE"
