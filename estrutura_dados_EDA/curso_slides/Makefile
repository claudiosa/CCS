# LaTeX Makefile
FILE=curso_EDA_SLIDES

all: $(FILE).pdf

.PHONY: clean


clean_latex:
	rm -f *.acn *.alg *.aux *.bbl *.blg *.brf *.fls *.glsdefs *.glo *.ilg *.ind *.ist *.lof *.log *.lol *.lot *.maf *.mtc* *.nav *.out *.snm *.spl *.synctex.* *.toc *.upa *.upb *.vrb 2> /dev/null
	@find . -name "*.fdb_latexmk" -exec rm -rf {} \;

clean:
	make clean_latex
#	rm -f ${FILE}.pdf

# *.bib *.sty
$(FILE).pdf: *.tex 
	pdflatex -shell-escape $(FILE).tex
	bibtex $(FILE)
	pdflatex -shell-escape $(FILE).tex
	pdflatex -shell-escape $(FILE).tex
	make clean_latex
