
chart_spread <- function(title="title",
                       LeftTextCode="leftU",
                       RightTextCode="rightU",
                       LeftChartCode="left",
                       footnoteLeft = NULL,
                       footnoteRight  = NULL,
                       RightChartCode="right",
                       BottomChartCode="bottom",
                       MapCode="map"){
  
  cat(paste0("\\begin{ChartPage}{ ",title," } \n"))
  
  cat(paste0("\\LeftText{\\IfFileExists{./Text/",LeftTextCode,".tex}{\\input{./Text/",LeftTextCode,"TXT.P1.ECON.1.1.tex}}{\\lipsum[2]}} \n"))
  
  if (exists("footnoteRight")) footnoteRightText <- paste0("\\footnotesize{",footnoteRight,"}  \n")
  if (!exists("footnoteRight")) footnoteRightText <- "\\vspace{-7pt} \n"
  
	cat(paste0("\\LeftChart{\begin{chart} \n 
	               \\input{./Captions/Caption_",LeftChartCode,".tex} \n",
	                footnoteRightText,
	               "\\IfFileExists{./Plots/",LeftChartCode,".pdf}{\\includegraphics[width = 4cm, height = 8cm]{{./Plots/",LeftChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))
	
	cat(paste0("\\RightChart{\begin{chart} \n 
	               \\input{./Captions/Caption_",RightChartCode,".tex} \n",
	               "\\vspace{-7pt} \n",
	               "\\IfFileExists{./Plots/",RightChartCode,".pdf}{\\includegraphics[width = 4cm, height = 8cm]{{./Plots/",RightChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))

	
  cat(paste0("\\BottomChart{\begin{chart} \n 
	               \\input{./Captions/Caption_",BottomChartCode,".tex} \n",
	           "\\vspace{-7pt} \n",
	           "\\IfFileExists{./Plots/",BottomChartCode,".pdf}{\\includegraphics[width = 8cm, height = 3cm]{{./Plots/",BottomChartCode,"}.pdf}}{} \n",
	           "\\end{chart}} \n"))
	
	cat("\\end{ChartPage}")
  
  
  cat(paste0("\\begin{figure} \n",
  "\\input{./Captions/Caption_",MapCode,".tex} \n", 
  "\\IfFileExists{./Maps/",MapCode,".pdf}{\\centering\\includegraphics[height = 1\\columnwidth, angle=90]{{./Maps/",MapCode,"}.pdf}\\par}{\\newpage\\thispagestyle{empty}\\mbox{}}{} \n",
  "\\end{figure}"
  ))
		
}

