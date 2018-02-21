TORINO, A PRETTY THEME FOR LATEX-BEAMER
=======================================

## Authors
Marco Barisione <marco@barisione.org>
Bozhidar Batsov

## Abstract
Beamer (http://latex-beamer.sourceforge.net/) is a LaTeX class that
allows you to create presentations.  Beamer contains several
full-featured (but a bit ugly) themes, so Marco wrote this pretty theme
(but with some missing features) called Torino.

## Installation
First of all, you have to install Beamer, directly from source or
using an already made package for your distro.  Then install the
theme, on a Unix system just type in a terminal:

```bash
$ sudo cp -r themes /usr/share/texmf/tex/latex/beamer/
$ sudo texhash
```

VEJA ONDE ESTAH O SEU BEAMER INSTALADO



## Usage
Now you are ready to use the theme, for documentation read the example
files: chameleon.tex nouvelle.tex and freewilly.tex.  Compiling them
you get some slides with documentation:

```bash
$ pdflatex chameleon.tex
$ pdflatex nouvelle.tex
$ pdflatex freewilly.tex
```

