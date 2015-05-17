#!/bin/bash

cd ~/btsync/fao_sync/pocketbooks/GSPB15/publication/
Rscript -e "library(knitr); knit('GSPB15.Rnw')"
pdflatex GSPB15.tex

# upload the output pdf to kapsi
scp GSPB15.pdf muuankarski@kapsi.fi:public_html/fao/GSPB15



