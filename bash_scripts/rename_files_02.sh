#!/bin/bash

##perl-rename -n 's/[0-9]\.[0-9]/[0-9]_[0-9]/' *.pdf
##perl-rename -n 's/_pdf/\.pdf/' *pdf
## option -n 
perl-rename  'y/[0-z]\.[0-z]\.pdf/[0-z]_[0-z]\.pdf/' *.pdf
perl-rename  's/_pdf/\.pdf/' *_pdf
