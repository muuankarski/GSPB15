#!/bin/bash

Rscript -e "library(knitr); knit('~/btsync/fao_sync/pocketbooks/GSPB15/publication/GSPB15.Rnw')"
pdflatex ~/btsync/fao_sync/pocketbooks/GSPB15/publication/GSPB15.tex

# upload the output pdf to kapsi
scp GSPB15.pdf muuankarski@kapsi.fi:public_html/fao/GSPB15



