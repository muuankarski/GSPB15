###########################################################################
## GSYB15: Plots and minitables for part 1
###########################################################################

source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
set_part(part=1)


###########################################################################
## POPULATION
###########################################################################


## ------------------------------------------------------------------------
# World rural and urban population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 1, n_colors=2) )
# Export plot
export_plot(manual_text = "World rural and urban population", placement = "tr")


## ------------------------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Annual population growth over the last ten years", placement="l")


## ------------------------------------------------------------------------
# Life expectancy at birth, countries with the lowest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="r")


## ------------------------------------------------------------------------
# Total economically active population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
## Export the plot
export_plot(manual_text = "Total economically active population", placement = "b")


# MAPS -------------------------------------------------------------------
# Rural population, share of total population

## Map info
mapInfo <- map_info(mapName = "M.P1.OVER.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()


###########################################################################
## ECONOMY
###########################################################################

## ------------------------------------------------------------------------
# Value added in agriculture, industry, and services as shares of GDP

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Value added in agriculture, industry, and services as shares of GDP", placement = "tr")


## ------------------------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Agriculture value added per worker, countries with the highest values in 2013", placement="l")

# C.P1.ECON.1.4 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


# C.P1.ECON.1.5 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
## Export the plot
export_plot(manual_text = "Annual value added in agriculture growth", placement="b")

## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.ECON.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()





##########################################################################
##########################################################################

# 
# 
# 
# # C_P1.OVER.1.7 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.OVER.1.7")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#        )
# ) # +
# ## Export the plot
# export_plot(placement = "tr")
# 
# 
# # C.P1.ECON.1.3 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.OVER.1.9")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#   )
# ## Export the plot
# export_plot()
# 
# 
# 
# 
# 
# ## ---------------------------------------------------------------- ##
# ## ---------------------------------------------------------------- ##
# 
# 
# 
# # C_P1.ECON.1.2 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.ECON.1.2")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 #                 legend_lab = subset(meta.lst$FULL,
#                 #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
#                 )
#        )
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.ECON.1.3 -----------------------------------------------------------
# 
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.ECON.1.3")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# # C_P1.ECON.1.4 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.ECON.1.4")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#        )
# )# +
# ## Export the plot
# export_plot()
# 
# 
# 
# 
# 
# 
# ## ---------------------------------------------------------------- ##
# ## ---------------------------------------------------------------- ##
# 
# # C_P1.LAWA.1.2 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.2")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                  subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                      Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.LAWA.1.3 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.3")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# # C_P1.LAWA.1.5 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.5")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# # C_P1.LAWA.1.6 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.6")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.LAWA.1.2 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.2")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.LAWA.1.7 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.7")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# 
# # C_P1.LAWA.1.8 ------------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LAWA.1.8")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.LABO.1.3 ------------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.LABO.1.3")
# ## Plot
# 
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                  legend_lab = subset(meta.lst$FULL,
#                                      subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# 
# # C_P1.INPU.1.6 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.INPU.1.6")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
# 
# # C_P1.INPU.1.7 -----------------------------------------------------------
# 
# ## Info
# plotInfo <- plot_info(plotName = "C_P1.INPU.1.7")
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#                 )
#        )# +
# ## Export the plot
# export_plot()
