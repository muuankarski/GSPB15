#!/bin/bash

cd ~/btsync/fao_sync/pocketbooks/GSPB15/publication/
Rscript -e "library(knitr); knit('GSPB15.Rnw')"
pdflatex GSPB15.tex

#pdftk GSPB15.pdf cat 19-20 output undernourishment.pdf
pdftk GSPB15.pdf cat 15-16 output investment.pdf
pdftk GSPB15.pdf cat 43-44 output energy.pdf
#pdftk GSPB15.pdf cat 60-61 output tables.pdf
pdftk GSPB15.pdf cat 51-232 output tables_all.pdf
pdftk GSPB15.pdf cat 1-50 output spreads.pdf
pdftk GSPB15.pdf cat 134 output table.pdf
pdftk GSPB15.pdf cat 233-end output definitions.pdf
convert -density 200 table.pdf table.jpg
pdftk GSPB15.pdf cat 179 output table2.pdf
convert -density 200 table2.pdf table2.jpg

pandoc comment_charts.md -o comment_charts.html
pandoc comment_tables.md -o comment_tables.html
pandoc comment_captions.md -o comment_captions.html
pandoc comment_definitions.md -o comment_definitions.html

# upload the output pdf to kapsi
scp GSPB15.pdf spreads.pdf table.jpg table2.jpg energy.pdf investment.pdf tables_all.pdf comment_captions.html comment_charts.html comment_tables.html definitions.pdf comment_definitions.html output muuankarski@kapsi.fi:public_html/fao/GSPB15
