default: pdf

pdf: 
	pdflatex livro-modelos-PR.tex
	bibtex livro-modelos-PR.aux
	pdflatex livro-modelos-PR.tex
	pdflatex livro-modelos-PR.tex

clean:
	rm *.toc
	rm *.pdf
	rm *.log
	rm *.aux
	rm *.out
	rm *.blg
	rm *.bbl
	rm *~