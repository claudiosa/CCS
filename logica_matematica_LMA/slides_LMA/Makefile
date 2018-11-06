.PHONY: main
main:
	pdflatex apres.tex
	bibtex apres
	pdflatex apres.tex
	pdflatex apres.tex
	
.PHONY: clean
clean:
	rm -f *.log *.dvi *.lof *.lot *.nlo *.out *.toc *.aux *.bak *.bbl *.blg *.nav *.snm *.vrb
	
.PHONY: view
view: main
	evince apres.pdf
