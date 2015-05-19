# ###########################################################################
# ## GSYB15: Plots and minitables for part 3
# ###########################################################################
# 
# # Colors part 3 -----------------------------------------------------------
# 
# source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
# set_part(part=3)
# 
# ###########################################################################
# ## Food supply
# ###########################################################################
# 
# # Lets wait fore the FSI indicators!!!!
# 
# # 1. Text
# # 2. graph: Protein and fat supply in crops primary equivalent (2000-09), world
# # 3. Dietary energy supply, top 20 (2000-02 vs. 2009-11)
# # 4. Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)
# # 5. Line graph: DES (kcal/cap/day), by region, 2000-2011
# # 6. Map: DES (kcal/cap/day), 2009-11
# 
# 
# ###########################################################################
# ## Growth in crop production
# ###########################################################################
# 
# # 1. Text
# # 2. Chart: fastest growing items between 2000-MRY
# 
# 
# # 3. Top 20 crop producing countries (based on crops, gross per capita production), 2000 vs. MRY
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
# ## Plot
# 
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
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
# )
# ## Export the plot
# export_plot(placement="l")
# 
# 
# # 4. Top 20 food producing countries (based on food, gross per capita production), 2000 vs. MRY
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
# ## Plot
# 
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
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
# )
# ## Export the plot
# export_plot(placement="r")
# 
# # 5. Bar chart: Growth in cereals production (production, harvested area, yield), world, 2000-MRY
# 
# 
# # 6. Map: Crops, gross per capita production (2004-06 = 100)
# 
# 
# 
# 
# 
# ###########################################################################
# ## Trends in the crop sector
# ###########################################################################
# 
# # 1. Text:
# # 2. Chart: top five items produced in MRY vs. 2000
# # 3. Top 20 Rice producing countries per capita, 2000 vs. MRY
# # 4. Top 20 maize producing countries per capita, 2000 vs. MRY
# # 5. Line chart: yield by region, 2000-MRY
# # 6. Map: Cereal producing countries
# 
# 
# ###########################################################################
# ## Trends in the livestock sector
# ###########################################################################
# 
# # 1. Text
# # 2. Per capita meat production (see chart 72 SYB2013)
# # 3. Per capita milk production, top 10 and bottom 10        
# # 4.Per capita egg production, top 10 and bottom 10
# # 5. Proportional pie charts on pig production, by region, 2000 vs. MRY
# # 6. Map: Cattle/buffaloes per sq km
# 
# 
# ###########################################################################
# ## Trends in the fisheries sector
# ###########################################################################
# 
# # 1. Text
# # 2. Stacked area graph: aquaculture vs. capture production
# # 3. 20 countries with highest value of capture production
# # 4. 20 countries with highest value of aquaculture production
# # 5. State of the world’s fishery stocks (see chart 79 in SYB2013)
# # 6. Map: Aquaculture producing countries, MRY (see map 48, WDI)
# 
# ###########################################################################
# ## Trade (please see ICN2 publication)
# ###########################################################################
# 
# 
