###########################################################################
## GSYB15: Plots and minitables for part 1
###########################################################################

# Colors part 1 -----------------------------------------------------------

colPart1 <- plot_colors(part = 1, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")

# Export the plot

export_plot <- function(manual_text =  "Add something here!", placement) { 
  
  if (placement %in% c("l","r")) {
    plotWidth <- 3.2
    plotHeight <- 5.9
  }
  if (placement == "b") {
    plotWidth <- 6
    plotHeight <- 3
  }
  if (placement == "tr") {
    plotWidth <- 3
    plotHeight <- 2.5
  }

    pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
      family = "PT Sans", title = NULL, width = plotWidth, height = plotHeight,
      pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
  
  print(eval(parse(text = plotInfo$plotName)))
  dev.off()
  
  ## Embed font
  embed_fonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""))
  ## Caption
  captions(objectName = plotInfo$plotName, output = captionsOutput, manual = manual_text)
  
}


# C.P1.OVER.1.2 -----------------------------------------------------------
# World rural and urban population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
               legend_lab <- c("Urban population","Rural population"),
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + # Extras
         centerYear() + 
         geom_vline(xintercept = 2013, linetype = "dashed") +
         scale_x_continuous(breaks=c(1960, 1980, 2000, 2020))
)
## Export the plot
export_plot(manual_text = "World rural and urban population", placement = "tr")


# C.P1.OVER.1.3 -----------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )  # extras
)
## Export the plot
export_plot(placement="l")


# C.P1.OVER.1.4 -----------------------------------------------------------

# Life expectancy at birth, countries with the lowest values in 2013


## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                   subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)
## Export the plot
export_plot(placement="r")



# C_P1.OVER.1.5 -----------------------------------------------------------
# Total economically active population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.5")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
               legend_lab = subset(meta.lst$FULL,
                                   subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]])
       )
)
## Export the plot
export_plot(manual_text = "Total economically active population", placement = "b")


# C.P1.ECON.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       )
)
## Export the plot
export_plot(placement = "tr")


# C.P1.ECON.1.3 -----------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )  # extras
)
## Export the plot
export_plot(placement="l")

# C.P1.ECON.1.4 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.4")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )  # extras
)
## Export the plot
export_plot(placement="r")


# C.P1.ECON.1.5 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.5")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       )  # extras
)
## Export the plot
export_plot(placement="b")







# C_P1.OVER.1.7 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.OVER.1.7")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
) # +
## Export the plot
export_plot(placement = "tr")


# C.P1.ECON.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.OVER.1.9")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
  )
## Export the plot
export_plot()





## ---------------------------------------------------------------- ##
## ---------------------------------------------------------------- ##



# C_P1.ECON.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.ECON.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
                )
       )
## Export the plot
export_plot()


# C_P1.ECON.1.3 -----------------------------------------------------------


## Info
plotInfo <- plot_info(plotName = "C_P1.ECON.1.3")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()

# C_P1.ECON.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.ECON.1.4")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       )
)# +
## Export the plot
export_plot()






## ---------------------------------------------------------------- ##
## ---------------------------------------------------------------- ##

# C_P1.LAWA.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                     Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()


# C_P1.LAWA.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.3")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()

# C_P1.LAWA.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()

# C_P1.LAWA.1.6 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.6")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()


# C_P1.LAWA.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()


# C_P1.LAWA.1.7 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.7")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()



# C_P1.LAWA.1.8 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LAWA.1.8")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()


# C_P1.LABO.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.LABO.1.3")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                 legend_lab = subset(meta.lst$FULL,
                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()


# C_P1.INPU.1.6 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.INPU.1.6")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()

# C_P1.INPU.1.7 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C_P1.INPU.1.7")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = gsyb15.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
                )
       )# +
## Export the plot
export_plot()
