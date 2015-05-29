#!/bin/bash

cd ~/btsync/fao_sync/pocketbooks/GSPB15/publication/
Rscript -e "library(knitr); knit('GSPB15.Rnw')"
pdflatex GSPB15.tex

pdftk GSPB15.pdf cat 51-60 output tables.pdf
pdftk GSPB15.pdf cat 51-end output tables_all.pdf
pdftk GSPB15.pdf cat 1-50 output spreads.pdf

# upload the output pdf to kapsi
scp GSPB15.pdf tables.pdf spreads.pdf output tables_all.pdf muuankarski@kapsi.fi:public_html/fao/GSPB15



