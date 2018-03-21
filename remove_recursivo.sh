#!/bin/bash
find . -name "*.log" -exec rm -rf {} \;
find . -name "*.aux" -exec rm -rf {} \;
find . -name "*.*~"  -exec rm  -rf {} \;
find . -name "*.fdb_latexmk"  -exec rm -rf {} \;
find . -name "*.exe"  -exec rm -rf {} \;
find . -name "a.out"  -exec rm -rf {} \;
find . -name ".dropbox"  -exec rm -rf {} \;
find . -name "*.dvi"  -exec rm -rf {} \;
echo FEITO
