#! /bin/sh
# negative vertical spacing between plots and caption that are of three rows

sed -i -e 's/Caption_C.P2.UNU.1.4.tex}}/Caption_C.P2.UNU.1.4.tex}} \\vspace{-7pt}/g' GSPB15.tex
sed -i -e 's/Caption_C.P1.ECON.1.4.tex}}/Caption_C.P1.ECON.1.4.tex}} \\vspace{-7pt}/g' GSPB15.tex
sed -i -e 's/Caption_C.P1.LABO.1.3.tex}}/Caption_C.P1.LABO.1.3.tex}} \\vspace{-7pt}/g' GSPB15.tex
sed -i -e 's/Caption_C.P1.INPU.1.4.tex}}/Caption_C.P1.INPU.1.4.tex}} \\vspace{-7pt}/g' GSPB15.tex
#sed -i -e 's/Caption_C.P1.INV.1.4.tex}}/Caption_C.P1.INV.1.4.tex}} \\vspace{-7pt}/g' GSPB15.tex
sed -i -e 's/Caption_C.P2.AV.1.3.tex}}/Caption_C.P2.AV.1.3.tex}} \\vspace{-7pt}/g' GSPB15.tex
sed -i -e 's/Caption_C.P2.ACCESS.1.4.tex}}/Caption_C.P2.ACCESS.1.4.tex}} \\vspace{-7pt}/g' GSPB15.tex

