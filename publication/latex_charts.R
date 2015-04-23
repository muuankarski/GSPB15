
chart_spread <- function(title="title",
                       LeftTextCode="leftU",
                       RightTextCode="rightU",
                       LeftChartCode="plot",
                       footnoteLeft = NULL,
                       footnoteRight  = NULL,
                       RightChartCode="plot",
                       BottomChartCode="plot",
                       MapCode="plot"){
  
  if (exists("footnoteRight")) footnoteRightText <- paste0("\\footnotesize{",footnoteRight,"}  \n")
  if (!exists("footnoteRight")) footnoteRightText <- "\\vspace{-7pt} \n"
  
  cat(paste0("\\begin{ChartPage}{ ",title," } \n"))
  
  cat(paste0("\\LeftText{\\IfFileExists{./Text/",LeftTextCode,".tex}{\\input{./Text/",LeftTextCode,".tex}}{\\lipsum[2]}} \n"))


  cat(paste0("\\RightText{\\IfFileExists{./Plots/",RightTextCode,".tex}  
	               {\\begin{table} \n
	               \\input{./Captions/Caption_",RightTextCode,".tex} \n
	               \\input{./Plots/",RightTextCode,".tex} \n
	               \\end{table}}} \n \n"))
  
#   cat(paste0("\\RightText{\\IfFileExists{./Plots/MT.P1.IAF.1.2.tex} \n 
# 	               {\\begin{table} \n
# 	               
#                   \\scriptsize \n
#                   \\begin{center} \n
#                   \\begin{tabular}{lrr} \n
#                   \\toprule \n
#                     & 1990-92 & 2012-14\\ \n
#                   \\midrule \n
#                   World & 18.7 & 11.3\\ \n
#                   Oceania & 15.7 & 14\\ \n
#                   \\toprule \n
#                   \\end{tabular} \n
#                   \\end{center} \n
# 	               
# 	               \\end{table}}} \n \n"))
  
  
	cat(paste0("\\LeftChart{\\begin{chart} \n 
	               \\input{./Captions/Caption_",LeftChartCode,".tex} \n",
	               "\\IfFileExists{./Plots/",LeftChartCode,".pdf}{\\includegraphics[width = 4cm, height = 8cm]{{./Plots/",LeftChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))
	
	cat(paste0("\\RightChart{\\begin{chart} \n 
	               \\input{./Captions/Caption_",RightChartCode,".tex} \n",
	               "\\vspace{-7pt} \n",
	               "\\IfFileExists{./Plots/",RightChartCode,".pdf}{\\includegraphics[width = 4cm, height = 8cm]{{./Plots/",RightChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))

	
  cat(paste0("\\BottomChart{\\begin{chart} \n 
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

