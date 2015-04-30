###########################################################################
## Charts ICN2 Statistical Pocketbook 2014
###########################################################################


###########################################################################
## Setting
###########################################################################

# Colors part 1 -----------------------------------------------------------

colPart1 <- plot_colors(part = 1, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")

# Export the plot

export_plot <- function(manual_text =  "Add something here!") { 

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


###########################################################################
## Malnutrition
###########################################################################

# Colors part 2 -----------------------------------------------------------

colPart1 <- plot_colors(part = 2, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")

# C.P1.IAF.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea) &
                                    FAOST_CODE %in% c(FAOcountryProfile[FAOcountryProfile[, 'SOFI_MACRO_REG'] == 'Asia' & !is.na(FAOcountryProfile[, 'SOFI_MACRO_REG']), 'FAOST_CODE'])")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
C.P1.IAF.1.3 <- C.P1.IAF.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2012-14"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2012-14"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
plotWidth  <- 3.2
plotHeight <- 5.1
export_plot(manual_text = "Asian countries with the highest number of people undernourished in 2012-14 (1990-92 and 2012-14)")

# C.P1.IAF.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea) &
                                    FAOST_CODE %in% c(FAOcountryProfile[FAOcountryProfile[, 'SOFI_MACRO_REG'] == 'Africa' & !is.na(FAOcountryProfile[, 'SOFI_MACRO_REG']), 'FAOST_CODE']) &
                                    !FAOST_CODE %in% c(250,201,178,206,276,277,29)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
C.P1.IAF.1.4 <- C.P1.IAF.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2012-14"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2012-14"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
plotWidth  <- 3.2
plotHeight <- 5.1
export_plot(manual_text = "African countries with the highest number of people undernourished in 2012-14 (1990-92 and 2012-14)")


# C.P1.IAF.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]])
       )
C.P1.IAF.1.5 <- C.P1.IAF.1.5 +
  scale_x_continuous(breaks = c(1992, 2002, 2007, 2011, 2014),
                     labels = c("1990-92", "2000-02", "2005-07", "2009-11", "2012-14"))
## Export the plot
plotWidth  <- 6
plotHeight <- 2.6
export_plot(manual_text="Number of people undernourished (1990-92 to 2012-14)")
