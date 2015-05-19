# ###########################################################################
# ## GSYB15: Plots and minitables for part 2
# ###########################################################################
# 
# source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
# set_part(part=2)
# 
# ###########################################################################
# ## UNDERNOURISHED
# ###########################################################################
# 
# ###########################################################################
# ## ANTROPOMETRIC
# ###########################################################################
# 
# ###########################################################################
# ## POVERTY
# ###########################################################################
# 
# 
# ###########################################################################
# ## AVAILABILITY
# ###########################################################################
# 
# 
# # ----------------------------------------------------------------------- #
# # Land area
# 
# # ## Info
# # plotInfo <- plot_info(plotName = "C.P2.LAND.1.2")
# # 
# # ## Plot
# # assign(plotInfo$plotName,
# #        plot_syb(x = plotInfo$xAxis,
# #                 y = plotInfo$yAxis,
# #                 group = plotInfo$group,
# #                 type = plotInfo$plotType,
# #                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
# #                                     Area %in% c(plotInfo$plotArea)")),
# #                 data = sybdata.df,
# #                 scale = plotInfo$scaling,
# #                 x_lab = plotInfo$xPlotLab,
# #                 y_lab = plotInfo$yPlotLab,
# #                 legend_lab = subset(meta.lst$FULL,
# #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
# #                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
# #        )
# # )
# # ## Export the plot
# # export_plot(manual_text = "This is LAND", placement = "tr")
# 
# # ----------------------------------------------------------------------- #
# # Energy supply derived from cereals, roots and tubers
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.AV.1.3")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Energy supply derived from cereals, roots and tubers",placement="l")
# 
# 
# # ----------------------------------------------------------------------- #
# # Protein supply quantity, grand total, 3 year averages
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.AV.1.4")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Protein supply quantity, grand total, 3 year averages",placement="r")
# 
# 
# # ----------------------------------------------------------------------- #
# # Protein of animal origin, 3 year averages
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.AV.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Protein of animal origin, 3 year averages", placement = "b")
# 
# 
# # MAPS -----------------------------------------------------
# # Food net per capita production value, 3 year averages 
# 
# ## Map info
# mapInfo <- map_info(mapName = "M.P2.AV.1.6", data = sybMaps.df, mapArea = "Territory")
# ## Create the map
# assign(mapInfo$mapName, meta_plot_map() )
# ## export the map
# export_map()
# 
# 
# ###########################################################################
# ## ACCESS
# ###########################################################################
# 
# # ----------------------------------------------------------------------- #
# # Depth of food decifit, 3 year averages
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.2")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
# ## Export the plot
# export_plot(manual_text = "Depth of food decifit, 3 year averages",placement="tr")
# 
# 
# # ----------------------------------------------------------------------- #
# # Domestic food price level index 
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.3")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
# ## Export the plot
# export_plot(manual_text = "Domestic food price level index",placement="l")
# 
# # ----------------------------------------------------------------------- #
# # Prevalence of food inadequacy, 3 year averages
# 
# # FSI variable: "AV3YPoFI.DISS"
# 
# # ## Info
# # plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
# # ## Plot
# # assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=3) )
# # ## Export the plot
# # export_plot(manual_text = "This is LAND", placement = "r")
# 
# 
# ##### -------------------------------------------------------
# # MAPS
# 
# # -----------------------------------------------------------
# # Road density
# 
# ## Map info
# mapInfo <- map_info(mapName = "M.P2.ACCESS.1.6", data = sybMaps.df, mapArea = "Territory")
# ## Create the map
# assign(mapInfo$mapName, meta_plot_map() )
# ## export the map
# export_map()
# 
# # ----------------------------------------------------------------------- #
# # ALTERNATIVE MAP TO ROAD DENSITY
# # Prevalence of undernourishment, 3 year averages