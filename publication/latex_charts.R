
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
  
  if (exists("footnoteRight")) footnoteLeftText <- paste0("\\footnotesize{",footnoteLeft,"}  \n")
  if (!exists("footnoteRight")) footnoteLefttText <- "\\vspace{-7pt} \n"
  
  #cat(paste0("\\begin{ChartPage}{ \\Large{",title,"} } \n")) # This fixes the font size but messes the tOC font size
  cat(paste0("\\begin{ChartPage}{ ",title," } \n"))
  
  cat(paste0("\\LeftText{\\IfFileExists{./Text/",LeftTextCode,".tex}{\\input{./Text/",LeftTextCode,".tex}}{\\lipsum[2]}} \n"))


  cat(paste0("\\RightText{\\IfFileExists{./Tables/",RightTextCode,".tex}  
	               {\\begin{table} \n
	               \\input{./Captions/Caption_",RightTextCode,".tex} \n
	               \\input{./Tables/",RightTextCode,".tex} \n
	               \\end{table}}} \n \n"))
   
	cat(paste0("\\LeftChart{\\begin{chart} \n 
	               \\input{./Captions/Caption_",LeftChartCode,".tex} \n",
	                footnoteLeftText,
	               "\\IfFileExists{./Plots/",LeftChartCode,".pdf}{\\includegraphics[width = 4.5cm, height = 7.5cm]{{./Plots/",LeftChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))
	
	cat(paste0("\\RightChart{\\begin{chart} \n 
	               \\input{./Captions/Caption_",RightChartCode,".tex} \n",
	                footnoteRightText,
	               "\\IfFileExists{./Plots/",RightChartCode,".pdf}{\\includegraphics[width = 4.5cm, height = 7.5cm]{{./Plots/",RightChartCode,"}.pdf}}{} \n",
	               "\\end{chart}} \n"))

	
  cat(paste0("\\BottomChart{\\begin{chart} \n 
	               \\input{./Captions/Caption_",BottomChartCode,".tex} \n",
	           "\\IfFileExists{./Plots/",BottomChartCode,".pdf}{\\includegraphics[width = 8cm, height = 4cm]{{./Plots/",BottomChartCode,"}.pdf}}{} \n",
	           "\\end{chart}} \n"))
	
	cat("\\end{ChartPage}")
  
  
  cat(paste0("\\begin{figure} \n",
  "\\input{./Captions/Caption_",MapCode,".tex} \n", 
  "\\IfFileExists{./Maps/",MapCode,".pdf}{\\centering\\includegraphics[height = 1\\columnwidth, angle=90]{{./Maps/",MapCode,"}.pdf}\\par}{\\newpage\\thispagestyle{empty}\\mbox{}}{} \n",
  "\\end{figure}"
  ))
		
}

