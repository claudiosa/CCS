#!/bin/bash
find . -name "*.log" -exec rm -rf {} \;
find . -name "*.aux" -exec rm -rf {} \;
find . -name "*.*~"  -exec rm  -rf {} \;
find . -name "*.fdb_latexmk"  -exec rm -rf {} \;
echo FEITO
