###########################################################################
## GSYB15: Plots and minitables for part 2
###########################################################################

# Colors part 2 -----------------------------------------------------------

colPart2 <- plot_colors(part = 2, 12)
col.main1 <- colPart2[["Main"]][1]
## color for the grid
col.main2 <- colPart2[["Main"]][2]
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

###########################################################################
## UNDERNOURISHED
###########################################################################

###########################################################################
## ANTROPOMETRIC
###########################################################################

###########################################################################
## POVERTY
###########################################################################


###########################################################################
## AVAILABILITY
###########################################################################


# ----------------------------------------------------------------------- #
# Land area

# ## Info
# plotInfo <- plot_info(plotName = "C.P2.LAND.1.2")
# 
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = sybdata.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#        )
# )
# ## Export the plot
# export_plot(manual_text = "This is LAND", placement = "tr")

# ----------------------------------------------------------------------- #
# Energy supply derived from cereals, roots and tubers

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.3")
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
export_plot(manual_text = "Energy supply derived from cereals, roots and tubers",placement="l")


# ----------------------------------------------------------------------- #
# Protein supply quantity, grand total, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.4")
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
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)
## Export the plot
export_plot(manual_text = "Protein supply quantity, grand total, 3 year averages",placement="r")


# ----------------------------------------------------------------------- #
# Protein of animal origin, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.5")
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
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
)

## Export the plot
export_plot(manual_text = "Protein of animal origin, 3 year averages", placement = "b")

###########################################################################
## ACCESS
###########################################################################

# ----------------------------------------------------------------------- #
# Depth of food decifit, 3 year averages


## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.2")
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
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
                )  # extras
)
## Export the plot
export_plot(manual_text = "Depth of food decifit, 3 year averages",placement="tr")


# ----------------------------------------------------------------------- #
# Domestic food price level index 

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.3")
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
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
                )
                )
## Export the plot
export_plot(manual_text = "Domestic food price level index",placement="l")


# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages


## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
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
export_plot(manual_text = "This is LAND", placement = "r")


# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages


## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.5")
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
export_plot(manual_text = "This is LAND", placement = "b")


###########################################################################
## ENERGY
###########################################################################

# ----------------------------------------------------------------------- #
# Land area

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.2")

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
export_plot(manual_text = "This is ENER", placement = "tr")

# ----------------------------------------------------------------------- #
# Top 20 biofuel producing countries

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.3")
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
export_plot(manual_text = "This is LAND",placement="l")


# ----------------------------------------------------------------------- #
# Arable land per capita, top 20 countries

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.4")
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
export_plot(manual_text = "This is LAND",placement="r")


# ----------------------------------------------------------------------- #
# Agricultural area

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.5")
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
export_plot(manual_text = "This is LAND", placement = "b")


###########################################################################
## FORESTRY
###########################################################################

# ----------------------------------------------------------------------- #
# production of select forest product

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.2")

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
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
                ) + centerYear()
       )
## Export the plot
export_plot(manual_text = "production of select forest product", placement = "tr")

# ----------------------------------------------------------------------- #
# Top and bottom 10 exporters of forest products


## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.3")
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
export_plot(manual_text = "Top and bottom 10 exporters of forest products",placement="l")


# ----------------------------------------------------------------------- #
# Top and bottom 10 importers of forest products


## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.4")
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
export_plot(manual_text = "Top and bottom 10 importers of forest products",placement="r")


# ----------------------------------------------------------------------- #
# Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.5")
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
export_plot(manual_text = "This is LAND", placement = "b")



###########################################################################
## CLIMATE CHANGE
###########################################################################

# ----------------------------------------------------------------------- #
# Greehouse gas emissions, highest in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.3")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
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
export_plot(manual_text = "Greehouse gas emissions, highest in 2012",placement="l")


# ----------------------------------------------------------------------- #
# Land use total emissions, highest 20 in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.4")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
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
export_plot(manual_text = "Land use total emissions, highest 20 in 2012",placement="l")


# Emissions by subsectors

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.5")

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
                y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]) +
         theme(axis.text.x = element_blank()) + 
         guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2))
)
## Export the plot
export_plot(manual_text = "Emissions by subsectors", placement = "b")


###########################################################################
## ENERGY
###########################################################################




# C.P4.ECON.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P4.ECON.1.2")
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


# C.P4.ECON.1.3 -----------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P4.ECON.1.3")
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

# C.P4.ECON.1.4 -----------------------------------------------------------
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







##########################################################################
##########################################################################