#!/bin/bash

cd ~/btsync/fao_sync/pocketbooks/GSPB15/publication/
Rscript -e "library(knitr); knit('GSPB15.Rnw')"
pdflatex GSPB15.tex

#pdftk GSPB15.pdf cat 19-20 output undernourishment.pdf
#pdftk GSPB15.pdf cat 60-61 output tables.pdf
#pdftk GSPB15.pdf cat 53-end output tables_all.pdf
pdftk GSPB15.pdf cat 1-50 output spreads.pdf
pdftk GSPB15.pdf cat 134 output table.pdf
convert -density 200 table.pdf table.jpg
pdftk GSPB15.pdf cat 179 output table2.pdf
convert -density 200 table2.pdf table2.jpg


# upload the output pdf to kapsi
scp GSPB15.pdf spreads.pdf table.jpg table2.jpg comment_charts.html comment_tables.html output muuankarski@kapsi.fi:public_html/fao/GSPB15
