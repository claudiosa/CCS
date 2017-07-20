# LaTeX Makefile
FILE=curso_EDA_SLIDES

all: $(FILE).pdf

.PHONY: clean

clean:
	rm -rf *.blg 
	rm -rf *.out 
	rm -rf *.bbl 
	rm -rf *.log
	rm -rf *.ind
	rm -rf *.ilg
	rm -rf *.lot
	rm -rf *.lof
	rm -rf *.ind
	rm -rf *.idx
	rm -rf *.aux
	rm -rf *.toc
	rm -f ${FILE}.pdf

# *.bib *.sty
$(FILE).pdf: *.tex 
	pdflatex -shell-escape $(FILE).tex
	#pdflatex -shell-escape $(FILE).tex
	#makeindex $(FILE)
	#bibtex $(FILE)
	#pdflatex -shell-escape $(FILE).tex
	#pdflatex -shell-escape $(FILE).tex
